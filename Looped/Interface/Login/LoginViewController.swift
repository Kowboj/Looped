import UIKit
import RxSwift

final class LoginViewController: ViewController {
    
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - Properties
    
    private let viewModel: LoginViewModelProtocol
    private let loginView = LoginView(buttonTitle: "Login")
    private let disposeBag = DisposeBag()
    
    // MARK: - Overrides
    
    override func loadView() {
        view = loginView
    }
    
    override func setupProperties() {
        super.setupProperties()
    }

    override func setupBindings() {
        super.setupBindings()
        
        loginView.closeButton.rx.tap
            .bind { [unowned self] in
                self.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        loginView.usernameTextField.rx.text
            .orEmpty
            .bind(to: viewModel.username)
            .disposed(by: disposeBag)
        
        loginView.passwordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
    
        loginView.loginButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.login()
            }
            .disposed(by: disposeBag)
    }
}
