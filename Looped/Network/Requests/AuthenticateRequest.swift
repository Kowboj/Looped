import Foundation

struct AuthenticateRequest: APIRequest {
    
    private let keys = LoopedKeys()
    
    var method: HttpMethod { return .POST }
    var path: String { return "oauth/token" }
    var body: [String : APIQueryParameter]? {
        return ["grant_type" : .string("client_credentials"),
                "client_id" : .string(keys.cLIENT_ID),
                "client_secret" : .string(keys.cLIENT_SECRET)
        ]
    }
}
