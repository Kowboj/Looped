import RxSwift
import RxCocoa

protocol LoginViewModelProtocol {
    func login()
    
    var username: Variable<String> { get }
    var password: Variable<String> { get }
    var isLogged: Observable<Bool> { get }
}

final class LoginViewModel: LoginViewModelProtocol {
    
    init(service: LoginServiceProtocol, sessionProvider: SessionProviding) {
        self.service = service
        self.sessionProvider = sessionProvider
        self.isValid = Observable.combineLatest(self.username.asObservable(), self.password.asObservable())
        { (username, password) in
            return username.count > 0
                && password.count > 0
        }
        sessionProvider.currentSession
            .map { $0 != nil }
            .asObservable()
            .bind(to: isLoggedSubject)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Properties
    
    private let service: LoginServiceProtocol
    private let sessionProvider: SessionProviding
    private let isLoggedSubject = PublishSubject<Bool>()
    private let isValid: Observable<Bool>
    private let disposeBag = DisposeBag()
    
    // MARK: - LoginViewModelProtocol
    
    let username = Variable<String>("")
    let password = Variable<String>("")
    lazy var isLogged: Observable<Bool> = {
        return isLoggedSubject
    }()
    
    func login() {
        // TODO: - check isValid, if false - show alert
        let activity = ActivityIndicator()
        service.login(username: username.value, password: password.value)
            .trackActivity(activity)
            .subscribe({ [weak self] (event) in
                if let session = event.element {
                    self?.sessionProvider.saveSession(session: session)
                }
            })
            .disposed(by: disposeBag)
    }
}
