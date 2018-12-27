import Foundation
import RxSwift

protocol RegisterViewModelProtocol {
    func register()
    
    var username: Variable<String> { get }
    var password: Variable<String> { get }
    var message: Variable<String> { get }
}

final class RegisterViewModel: RegisterViewModelProtocol {
    
    init(service: RegisterServiceProtocol) {
        self.service = service
    }
    
    // MARK: - Properties
    
    private let service: RegisterServiceProtocol
    private let disposeBag = DisposeBag()
    
    // MARK: - RegisterViewModelProtocol
    
    let username = Variable<String>("")
    let password = Variable<String>("")
    let message = Variable<String>("")
    
    func register() {
        // TODO: - check isValid, if false - show alert
        let activity = ActivityIndicator()
        service.register(username: username.value, password: password.value)
            .trackActivity(activity)
            .catchError({ (error) -> Observable<String> in
                return Observable.just(error.localizedDescription)
            })
            .bind(to: message)
            .disposed(by: disposeBag)
    }
}
