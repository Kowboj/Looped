import Foundation

enum APIError: Error {
    case noConnection
    case incorrectURL(url: String)
    case incorrectStatusCode(code: Int, data: Data?)
    case missingData
}
