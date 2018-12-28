import Foundation

struct RegisterRequest: APIRequest {
    
    private let userName: String
    private let password: String
    private let keys = LoopedKeys()
    
    init(userName: String, password: String) {
        self.userName = userName
        self.password = password
    }
    var method: HttpMethod { return .POST }
    var path: String { return "users" }
    var body: [String : APIQueryParameter]? {
        return ["username" : .string(userName),
                "password" : .string(password)
        ]
    }
}
