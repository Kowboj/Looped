import Foundation

extension URLComponents {
    
    init(request: APIRequest) {
        self = {
            var components = URLComponents()
            components.scheme = request.service.scheme.rawValue
            components.host = request.service.host
            components.path = "/" + NSString.path(withComponents: [request.service.root, request.path])
            components.queryItems = request.serializeToQuery()
            return components
        }()
    }
}
