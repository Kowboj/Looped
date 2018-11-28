import UIKit
import RxSwift

final class DefaultAPIClient: APIClient {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func send(request: APIRequest) -> Single<APIResponse> {
        return Single<APIResponse>.create { [unowned self] single in
            var urlRequest: URLRequest
            do {
                urlRequest = try URLRequest(request: request)
            } catch let error {
                single(.error(error))
                return Disposables.create()
            }
            
            let task = self.session.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                        single(.error(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "You need internet connection at first launch"])))
                    } else {
                        single(.error(error))
                    }
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    single(.error(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "No response"])))
                    return
                }
                
                if 200..<300 ~= response.statusCode {
                    single(.success(APIResponse(data: data, response: response)))
                } else {
                    single(.error(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Incorrect status code"])))
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
