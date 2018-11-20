import Foundation

enum Scheme: String {
    case http
    case https
}

protocol APIService {
    var scheme: Scheme { get }
    var host: String { get }
    var root: String { get }
}

extension APIService {
    var scheme: Scheme { return .http }
}
