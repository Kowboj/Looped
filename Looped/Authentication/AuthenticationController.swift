import Foundation

protocol AuthenticationControlling {
    func authorizeRequest(request: inout URLRequest)
}

final class AuthenticationController: AuthenticationControlling {
    private let sessionProvider: SessionProviding

    init(sessionProvider: SessionProviding) {
        self.sessionProvider = sessionProvider
    }

    func authorizeRequest(request: inout URLRequest) {
        if let accessToken = sessionProvider.lastSession?.token {
            let headerValue = "Bearer " + accessToken
            request.setValue(headerValue, forHTTPHeaderField: "Authorization")
        }
    }
}
