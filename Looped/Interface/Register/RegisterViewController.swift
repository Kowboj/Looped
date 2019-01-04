import UIKit
import RxSwift

final class RegisterViewController: ViewController {

    init(viewModel: RegisterViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - Properties
    
    private let viewModel: RegisterViewModelProtocol
    private let registerView = RegisterView()
    private let disposeBag = DisposeBag()

    // MARK: - Overrides
    
    override func loadView() {
        view = registerView
    }
    
    override func setupBindings() {
        super.setupBindings()
        
        let textFieldsObservable = Observable.combineLatest(registerView.usernameTextField.rx.text.orEmpty, registerView.passwordTextField.rx.text.orEmpty)
        
        textFieldsObservable
            .map { $0.0.count > 3 && $0.1.count > 3 }
            .bind(to: registerView.loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        registerView.loginButton.rx.tap
            .debounce(0.5, scheduler: MainScheduler.instance)
            .withLatestFrom(textFieldsObservable)
            .subscribe(onNext: { [weak self] (userName, password) in
                self?.viewModel.register(userName: userName, password: password)
            })
            .disposed(by: disposeBag)
        
        registerView.closeButton.rx.tap
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
                    self.registerView.infoLabel.text = "No internet connection"
                case .incorrectURL(let url):
                    self.registerView.infoLabel.text = url
                case .incorrectStatusCode( _, let data):
                    if let data = data {
                        do {
                            let message = try JSONDecoder().decode(ErrorResponse.self, from: data).errorMessage.description
                            self.registerView.infoLabel.text = message
                        } catch let error {
                            self.registerView.infoLabel.text = "Decoding error - \(error.localizedDescription)"
                        }
                    }
                case .missingData:
                    self.registerView.infoLabel.text = "No data in response"
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.didLogin
            .subscribe(onCompleted: { [unowned self] in
                self.registerView.infoLabel.text = "Did login"
                // TODO: Dismiss
            })
            .disposed(by: disposeBag)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}
