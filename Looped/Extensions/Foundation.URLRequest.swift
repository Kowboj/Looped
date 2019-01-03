import Foundation

extension URLRequest {
    init(request: APIRequest) throws {
        guard let url = URLComponents(request: request).url else { throw APIError.incorrectURL(url: request.path) }
        self.init(url: url)
        self.httpMethod = request.method.rawValue
        
        httpMethod = request.method.rawValue
        allHTTPHeaderFields = [
            "Accept": "application/json",
            "Content-Type": "application/json; charset=uft-8"
        ]
        
        if let header = request.header {
            allHTTPHeaderFields = allHTTPHeaderFields!.merging(header) { $1 }
        }
        
        if let body = request.body, let data = try? JSONEncoder().encode(body) {
            httpBody = data
        }
    }
}
