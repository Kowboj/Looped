import Foundation
import RxSwift

protocol RegisterViewModelProtocol {
    func register()

    // TODO: Get rid of variables
    var username: Variable<String> { get }
    var password: Variable<String> { get }
    var message: Variable<String> { get }

    var isLoading: Observable<Bool> { get }

    var error: Observable<Error> { get }
}

final class RegisterViewModel: RegisterViewModelProtocol {
    
    init(service: RegisterServiceProtocol) {
        self.service = service
    }
    
    // MARK: - Properties

    private let activity = ActivityIndicator()
    private let service: RegisterServiceProtocol
    private let disposeBag = DisposeBag()
    private let errorSubject = PublishSubject<Error>()
    
    // MARK: - RegisterViewModelProtocol
    
    let username = Variable<String>("")
    let password = Variable<String>("")
    let message = Variable<String>("")

    var isLoading: Observable<Bool> {
        return activity.asSharedSequence().asObservable()
    }

    lazy var error: Observable<Error> = {
        return errorSubject
    }()

    func register() {
        // TODO: - check isValid, if false - show alert
        service.register(username: username.value, password: password.value)
            .trackActivity(activity)
            .catchError({ [weak self] error in
                self?.errorSubject.onNext(error)
                return .empty()
            })
            .bind(to: message)
            .disposed(by: disposeBag)
    }
}
