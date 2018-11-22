import Foundation

struct SearchRequest: APIRequest {
    
    private let text: String
    
    init(text: String) {
        self.text = text
    }
    
    var method: HttpMethod { return .GET }
    var path: String { return "search" }
    var query: [String : APIQueryParameter] {
        return ["search_text" : APIQueryParameter.string(text)]
    }
}
