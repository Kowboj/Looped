import Foundation
import RxSwift

protocol RegisterViewModelProtocol {
    func register(userName: String, password: String)

    var isLoading: Observable<Bool> { get }
    var error: Observable<Error> { get }
    var didLogin: Completable { get }
}

final class RegisterViewModel: RegisterViewModelProtocol {
    
    init(service: RegisterServiceProtocol, sessionProvider: SessionProviding) {
        self.service = service
        self.sessionProvider = sessionProvider
        if sessionProvider.lastSession == nil {
            authenticate()
        }
    }
    
    // MARK: - Properties

    private let service: RegisterServiceProtocol
    private let sessionProvider: SessionProviding
    private let activity = ActivityIndicator()
    private let errorSubject = PublishSubject<Error>()
    private let didLoginSubject = PublishSubject<Void>()
    private let disposeBag = DisposeBag()
    
    // MARK: - RegisterViewModelProtocol
    
    var isLoading: Observable<Bool> {
        return activity.asSharedSequence().asObservable()
    }

    lazy var error: Observable<Error> = {
        return errorSubject
    }()

    lazy var didLogin: Completable = {
        return didLoginSubject.asCompletable()
    }()
    
    func register(userName: String, password: String) {
        
        service.register(userName: userName, password: password)
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
    
    func authenticate() {
        service.authenticate()
            .trackActivity(activity)
            .catchError({ [weak self] error in
                self?.errorSubject.onNext(error)
                return .empty()
            })
            .subscribe(onNext: { [weak self] session in
                self?.sessionProvider.saveSession(session: session)
            })
            .disposed(by: disposeBag)
    }
}
