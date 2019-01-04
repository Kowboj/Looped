import UIKit
import RxSwift

protocol LoginViewControllerDelegate: class {
    func onSuccess()
}

final class LoginViewController: ViewController {
    
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - Properties
    
    private let viewModel: LoginViewModelProtocol
    private let loginView = LoginView()
    private let disposeBag = DisposeBag()
    weak var successDelegate: LoginViewControllerDelegate?
    
    // MARK: - Overrides
    
    override func loadView() {
        view = loginView
    }

    override func setupBindings() {
        super.setupBindings()

        let textFieldsObservable = Observable.combineLatest(loginView.usernameTextField.rx.text.orEmpty, loginView.passwordTextField.rx.text.orEmpty)

        textFieldsObservable
            .map {  $0.0.count > 0 && $0.1.count > 0 }
            .bind(to: loginView.loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
    
        loginView.loginButton.rx.tap
            .debounce(0.5, scheduler: MainScheduler.instance)
            .withLatestFrom(textFieldsObservable)
            .subscribe(onNext: { [weak self] (userName, password) in
                self?.viewModel.login(userName: userName, password: password)
            })
            .disposed(by: disposeBag)

        loginView.closeButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)

        viewModel.error
            .map { $0 as? APIError }
            .unwrap()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { apiError in
                switch apiError {
                case .noConnection:
                    self.loginView.infoLabel.text = "No internet connection"
                case .incorrectURL(let url):
                    self.loginView.infoLabel.text = url
                case .incorrectStatusCode( _, let data):
                    if let data = data {
                        do {
                            let message = try JSONDecoder().decode(ErrorResponse.self, from: data).errorMessage.description
                            self.loginView.infoLabel.text = message
                        } catch let error {
                            self.loginView.infoLabel.text = "Decoding error - \(error.localizedDescription)"
                        }
                    }
                case .missingData:
                    self.loginView.infoLabel.text = "No data in response"
                }
            })
            .disposed(by: disposeBag)

        viewModel.didLogin
            .observeOn(MainScheduler.instance)
            .subscribe(onCompleted: { [unowned self] in
                self.successDelegate?.onSuccess()
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}
