import UIKit

final class DefaultAPIClient: APIClient {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func send(request: APIRequest, completion: @escaping (Result<Data>) -> ()) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        do {
            let request = try URLRequest(request: request)
            session.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data {
                    completion(Result.success(data))
                } else if let error = error {
                    completion(Result.failure(error))
                }
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }).resume()
        } catch let error {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            completion(Result<Data>.failure(error))
        }
    }
    
    private func decode<T: Decodable>(data: Data) -> Result<T> {
        do {
            let model = try JSONDecoder().decode(T.self, from: data)
            return Result.success(model)
        } catch let error {
            return Result.failure(error)
        }
    }
}
