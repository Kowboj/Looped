import Foundation

final class DefaultAPIClient: APIClient {
    
    private let session: URLSession
    
    init() {
        session = .shared
    }
    
    func send(request: APIRequest, completion: @escaping (Result<Data>) -> ()) {
        do {
            let request = try URLRequest(request: request)
            session.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data {
                    completion(Result.success(data))
                } else if let error = error {
                    completion(Result.failure(error))
                }
            }).resume()
        } catch let error {
            completion(Result<Data>.failure(error))
        }
    }
    
//    func perform<T: Decodable>(request: APIRequest, completion: @escaping (Result<RoznowskieResponse<T>>) -> ()) {
//        do {
//            let request = try URLRequest(request: request)
//            session.dataTask(with: request) { (data, response, error) in
//                if let data = data {
//                    completion(self.decode(data: data))
//                } else if let error = error {
//                    completion(Result.failure(error))
//                }
//            }.resume()
//        } catch let error {
//            completion(Result.failure(error))
//        }
//    }
    
    private func decode<T: Decodable>(data: Data) -> Result<T> {
        do {
            let model = try JSONDecoder().decode(T.self, from: data)
            return Result.success(model)
        } catch let error {
            return Result.failure(error)
        }
    }
}
