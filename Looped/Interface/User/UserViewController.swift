import UIKit

protocol UserViewControllerFlowDelegate: class, DetailsShowable {}

final class UserViewController: ViewController {
    
    // MARK: - Properties
    private let userView = UserView()
    weak var flowDelegate: UserViewControllerFlowDelegate?
    
    // MARK: - Overrides
    override func loadView() {
        view = userView
    }
}
