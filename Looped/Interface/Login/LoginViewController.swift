import UIKit

final class LoginViewController: ViewController {
    
    // MARK: - Properties
    private let loginView = LoginView()
    weak var userFlowDelegate: UserViewControllerFlowDelegate?
    
    // MARK: - Overrides
    override func loadView() {
        view = loginView
    }
    
    override func setupProperties() {
        super.setupProperties()
        loginView.closeButton.addTarget(self, action: #selector(close), for: UIControl.Event.touchUpInside)
    }
    
    // MARK: - Private
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
}
