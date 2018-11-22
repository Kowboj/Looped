import Foundation

enum HttpMethod: String {
    case GET
    case POST
}

protocol APIRequest {
    var path: String { get }
    var service: APIService { get }
    var method: HttpMethod { get }
    var query: [String: APIQueryParameter] { get }
    var body: [String: APIQueryParameter]? { get }
}

extension APIRequest {
    var service: APIService { return GfycatService() }
    var method: HttpMethod { return .GET }
    var query: [String: APIQueryParameter] { return [:] }
    var body: [String: APIQueryParameter]? { return nil }
}

extension APIRequest {
    
    func serializeToQuery() -> [URLQueryItem] {
        return self.query.flatMap { serializeToQueryComponent(key: $0, value: $1) }
    }
    
    private func serializeToQueryComponent(key: String, value: APIQueryParameter) -> [URLQueryItem] {
        switch value {
        case .null:
            return []
        case .bool(let bool):
            return [URLQueryItem(name: key, value: bool ? "1" : "0")]
        case .double(let double):
            return [URLQueryItem(name: key, value: "\(double)")]
        case .int(let int):
            return [URLQueryItem(name: key, value: "\(int)")]
        case .string(let string):
            return [URLQueryItem(name: key, value: string)]
        case .dictionary(let dictionary):
            return dictionary.flatMap { serializeToQueryComponent(key: "\(key)[\($0.key)]", value: $0.value) }
        }
    }
}
