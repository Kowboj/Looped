import Foundation

protocol SessionStoring {

    func getSession() -> Session?
    func saveSession(session: Session) -> Bool
    func deleteSession(session: Session) -> Bool
}

final class SessionStore: SessionStoring {

    // MARK: - Properties

    private enum SessionStoreKeys: String {
        case token
    }
    

    func getSession() -> Session? {
        let tag = SessionStoreKeys.token.rawValue.data(using: .utf8)!
        let getQuery: [String: Any] = [kSecClass as String: kSecClassKey,
                                       kSecAttrApplicationTag as String: tag,
                                       kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
                                       kSecReturnRef as String: true]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(getQuery as CFDictionary, &item)
        guard status == errSecSuccess else { return nil }
        guard let token = item?.stringValue else { return nil }
        return Session(token: token)
    }

    func saveSession(session: Session) -> Bool {
        let token = session.token
        let tag = SessionStoreKeys.token.rawValue.data(using: .utf8)!
        let addQuery: [String: Any] = [kSecClass as String: kSecClassKey,
                                       kSecAttrApplicationTag as String: tag,
                                       kSecValueRef as String: token]
        let status = SecItemAdd(addQuery as CFDictionary, nil)
        guard status == errSecSuccess else { return false }
        return true
    }

    func deleteSession(session: Session) -> Bool {
        let token = session.token
        let tag = SessionStoreKeys.token.rawValue.data(using: .utf8)!
        let deleteQuery: [String: Any] = [kSecClass as String: kSecClassKey,
                                       kSecAttrApplicationTag as String: tag,
                                       kSecValueRef as String: token]
        let status = SecItemDelete(deleteQuery as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else { return false }
        return true
    }
}

