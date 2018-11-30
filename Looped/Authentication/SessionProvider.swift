import RxSwift

protocol SessionProviding {
    var lastSession: Session? { get }
    var currentSession: Observable<Session?> { get }
    func saveSession(session: Session)
    func authorizeRequest(request: inout APIRequest)
}

final class SessionProvider: SessionProviding {
    
    var lastSession: Session?
    
    func authorizeRequest(request: inout APIRequest) {

    }

    private let sessionStore: SessionStoring

    init(sessionStore: SessionStoring) {
        self.sessionStore = sessionStore
    }

    lazy var currentSession: Observable<Session?> = {
        return .just(sessionStore.getSession())
    }()

    func saveSession(session: Session) {

    }
}

struct Session {
    let name: String
}
