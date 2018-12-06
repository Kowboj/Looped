import Foundation

struct NewRequest: APIRequest {
    var path: String
    var service: APIService
    var method: HttpMethod
    var query: [String: APIQueryParameter]
    var body: [String: APIQueryParameter]
    var header: [String: String]
    
    init(path: String, service: APIService, method: HttpMethod, query: [String: APIQueryParameter], body: [String: APIQueryParameter], header: [String: String]) {
        self.path = path
        self.service = service
        self.method = method
        self.query = query
        self.body = body
        self.header = header
    }
}
