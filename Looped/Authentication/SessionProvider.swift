import RxSwift

protocol SessionProviding {
    var lastSession: Session? { get }
    var currentSession: Observable<Session?> { get }

    func saveSession(session: Session)
    func deleteSession(session: Session)
}

final class SessionProvider: SessionProviding {
    
    init(sessionStore: SessionStoring) {
        self.sessionStore = sessionStore
    }
    
    // MARK: - Properties
    
    private let sessionStore: SessionStoring
    private let disposeBag = DisposeBag()

    // MARK: - SessionProvidingProtocol
    
    func saveSession(session: Session) {
        lastSession = session
        return sessionStore.save(session: session)
    }
    
    func deleteSession(session: Session) {
        return sessionStore.deleteSession()
    }
    
    lazy var currentSession: Observable<Session?> = {
        return .just(sessionStore.getSession())
    }()
    
    var lastSession: Session?
}

struct Session {
    let token: String
    let refreshToken: String?
    
    init(token: String, refreshToken: String?) {
        self.token = token
        self.refreshToken = refreshToken
    }
}
