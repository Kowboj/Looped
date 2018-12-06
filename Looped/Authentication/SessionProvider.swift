import RxSwift

protocol SessionProviding {
    var lastSession: Session? { get }
    var currentSession: Observable<Session?> { get }

    func saveSession(session: Session) -> Bool
    func deleteSession(session: Session) -> Bool
}

final class SessionProvider: SessionProviding {
    
    // MARK: - Properties
    
    private let sessionStore: SessionStoring
    private let disposeBag = DisposeBag()

    // MARK: - Initializers
    
    init(sessionStore: SessionStoring) {
        self.sessionStore = sessionStore
    }

    // MARK: - SessionProvidingProtocol
    
    func saveSession(session: Session) -> Bool {
        lastSession = session
        return sessionStore.saveSession(session: session)
    }
    
    func deleteSession(session: Session) -> Bool {
        return sessionStore.deleteSession(session: session)
    }
    
    lazy var currentSession: Observable<Session?> = {
        return .just(sessionStore.getSession())
    }()
    
    var lastSession: Session?
    
    func authorizeRequest(request: APIRequest) -> APIRequest? {
        guard let session = lastSession else { return nil }
        return NewRequest(path: request.path, service: request.service, method: request.method, query: request.query, body: request.body!, header: ["Authorization": "Bearer \(session.token)"])
    }
}

struct Session {
    let token: String
}
