import Foundation

struct RegisterRequest: APIRequest {
    
    private let username: String
    private let password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    var method: HttpMethod { return .POST }
    var path: String { return "users" }
    var body: [String : APIQueryParameter]? {
        return ["username" : .string(username),
                "password" : .string(password)
        ]
    }
}
