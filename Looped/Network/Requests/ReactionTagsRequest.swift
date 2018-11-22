import Foundation

struct ReactionTagsRequest: APIRequest {
    
    var method: HttpMethod { return .GET }
    var path: String { return "reactions/populated" }
}
