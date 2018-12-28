import RxSwift
import RxCocoa

protocol LoginViewModelProtocol {
    func login(userName: String, password: String)

    var isLoading: Observable<Bool> { get }
    var error: Observable<Error> { get }
    var didLogin: Completable { get }
}

final class LoginViewModel: LoginViewModelProtocol {
    
    init(service: LoginServiceProtocol, sessionProvider: SessionProviding) {
        self.service = service
        self.sessionProvider = sessionProvider
    }
    
    // MARK: - Properties
    
    private let service: LoginServiceProtocol
    private let sessionProvider: SessionProviding
    private let activity = ActivityIndicator()
    private let errorSubject = PublishSubject<Error>()
    private let didLoginSubject = PublishSubject<Void>()
    private let disposeBag = DisposeBag()
    
    // MARK: - LoginViewModelProtocol

    var isLoading: Observable<Bool> {
        return activity.asSharedSequence().asObservable()
    }

    lazy var error: Observable<Error> = {
        return errorSubject
    }()

    lazy var didLogin: Completable = {
        return didLoginSubject.asCompletable()
    }()

    func login(userName: String, password: String) {

        service.login(username: userName, password: password)
            .trackActivity(activity)
            .catchError({ [weak self] error in
                self?.errorSubject.onNext(error)
                return .empty()
            })
            .subscribe(onNext: { [weak self] session in
                self?.sessionProvider.saveSession(session: session)
                self?.didLoginSubject.onCompleted()
            })
            .disposed(by: disposeBag)

    }
}
