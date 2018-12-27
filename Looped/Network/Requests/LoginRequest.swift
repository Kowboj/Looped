import Foundation

struct LoginRequest: APIRequest {
    
    private let username: String
    private let password: String
    private let keys = LoopedKeys()
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }

    var method: HttpMethod { return .POST }
    var path: String { return "oauth/token" }
    var body: [String : APIQueryParameter]? {
        return ["grant_type" : .string("client_credentials"),
                "client_id" : .string(keys.cLIENT_ID),
                "client_secret" : .string(keys.cLIENT_SECRET),
                "username" : .string(username),
                "password" : .string(password)
        ]
    }
}
