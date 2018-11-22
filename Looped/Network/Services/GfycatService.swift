import Foundation

final class GfycatService: APIService {
    var root: String { return "v1" }
    var host: String { return "api.gfycat.com" }
    var scheme: Scheme { return .https }
}
