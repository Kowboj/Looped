import UIKit

final class UserViewController: ViewController {
    
    // MARK: - Properties
    private let userView = UserView()
    
    // MARK: - Private
    override func loadView() {
        view = userView
    }
}
