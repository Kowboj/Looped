import Foundation

struct LoginRequest: APIRequest {
    
    private let username: String
    private let password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    var method: HttpMethod { return .POST }
    var path: String { return "oauth/token" }
    var body: [String : APIQueryParameter]? {
        return ["grant_type" : .string("client_credentials"),
                "client_id" : .string(""),
                "client_secret" : .string(""),
                "username" : .string(username),
                "password" : .string(password)
        ]
    }
}
