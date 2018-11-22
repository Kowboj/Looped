import Foundation

protocol APIClient {
    func send(request: APIRequest, completion: @escaping (Result<Data>) -> ())
}
