import Foundation

protocol SessionStoring {

    func getSession() -> Session?
    func saveSession(session: Session)
    func deleteSession(session: Session)
}

final class SessionStore: SessionStoring {

    func getSession() -> Session? {
        return nil // TODO: Save in Keychain
    }

    func saveSession(session: Session) {

    }

    func deleteSession(session: Session) {

    }
}

