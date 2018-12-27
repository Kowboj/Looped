import UIKit
import RxSwift

final class RegisterViewController: ViewController {

    init(viewModel: RegisterViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - Properties
    
    private let viewModel: RegisterViewModelProtocol
    private let registerView = RegisterView(buttonTitle: "Register")
    private let disposeBag = DisposeBag()

    // MARK: - Overrides
    
    override func loadView() {
        view = registerView
    }
    
    override func setupProperties() {
        super.setupProperties()
    }
    
    override func setupBindings() {
        super.setupBindings()
        
        viewModel.message
            .asObservable()
            .bind(to: registerView.infoLabel.rx.text)
            .disposed(by: disposeBag)
        
        registerView.closeButton.rx.tap
            .bind { [unowned self] in
                self.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        registerView.usernameTextField.rx.text
            .orEmpty
            .bind(to: viewModel.username)
            .disposed(by: disposeBag)
        
        registerView.passwordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        registerView.loginButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.register()
            }
            .disposed(by: disposeBag)
    }
}
