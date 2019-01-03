import Foundation
import KeychainAccess

protocol SessionStoring {

    func getSession() -> Session?
    func save(session: Session)
    func deleteSession()
}

final class SessionStore: SessionStoring {

    // MARK: - Properties

    private var keychain: Keychain = {
        return Keychain(service: SessionStoreKeys.service.rawValue)
    }()
    
    private enum SessionStoreKeys: String {
        case service
        case token
        case refreshToken
    }
    
    // MARK: - SessionStoringProtocol
    
    func getSession() -> Session? {
        let tokenTag = SessionStoreKeys.token.rawValue
        let refreshTokenTag = SessionStoreKeys.refreshToken.rawValue
        if let token = keychain[tokenTag], let refreshToken = keychain[refreshTokenTag] {
            return Session(token: token, refreshToken: refreshToken)
        }
        return nil
    }

    func save(session: Session) {
        let tokenTag = SessionStoreKeys.token.rawValue
        let refreshTokenTag = SessionStoreKeys.refreshToken.rawValue
        keychain[tokenTag] = session.token
        keychain[refreshTokenTag] = session.refreshToken
    }

    func deleteSession() {
        let tokenTag = SessionStoreKeys.token.rawValue
        let refreshTokenTag = SessionStoreKeys.refreshToken.rawValue
        keychain[tokenTag] = nil
        keychain[refreshTokenTag] = nil
    }
}

