import Foundation
@testable import Looped

struct MockAPIRequest: APIRequest {
    var path: String {
        return "fixed_path"
    }
}
