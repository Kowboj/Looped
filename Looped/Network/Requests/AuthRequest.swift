import Foundation

struct AuthRequest: APIRequest {
    
    var method: HttpMethod { return .POST }
    var path: String { return "oauth/token" }
    var body: [String : APIQueryParameter]? {
        return ["grant_type" : .string("client_credentials"),
                "client_id" : .string(""),
                "client_secret" : .string("")
        ]
    }
}
