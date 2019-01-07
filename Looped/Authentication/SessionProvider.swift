import RxSwift

protocol SessionProviding {
    var lastSession: Session? { get }
    var currentSession: Observable<Session?> { get }

    func saveSession(session: Session)
    func deleteSession()
}

final class SessionProvider: SessionProviding {
    
    init(sessionStore: SessionStoring) {
        self.sessionStore = sessionStore
        lastSession = sessionStore.getSession()
    }
    
    // MARK: - Properties
    
    private let sessionStore: SessionStoring
    private let disposeBag = DisposeBag()
    private lazy var currentSessionSubject = BehaviorSubject<Session?>(value: sessionStore.getSession())

    // MARK: - SessionProvidingProtocol
    
    var lastSession: Session?
    
    lazy var currentSession: Observable<Session?> = {
        return currentSessionSubject
    }()
    
    func saveSession(session: Session) {
        lastSession = session
        currentSessionSubject.onNext(session)
        sessionStore.save(session: session)
    }
    
    func deleteSession() {
        currentSessionSubject.onNext(nil)
        sessionStore.deleteSession()
    }
}

struct Session {
    let token: String
    let refreshToken: String?
    
    init(token: String, refreshToken: String?) {
        self.token = token
        self.refreshToken = refreshToken
    }
}
