import UIKit

final class UserFlowController: FlowController {
    
    let rootControllersFactory = UserFlowControllerFactory()
    lazy var rootViewController: UINavigationController = {
        navigationController.viewControllers = [rootControllersFactory.buildUserViewController(delegate: self)]
        
        return navigationController
    }()
    
    private lazy var navigationController: UINavigationController = {
        return UINavigationController()
    }()
    
    init() {
        navigationController.show(rootViewController, sender: nil)
    }
}

extension UserFlowController: UserViewControllerFlowDelegate {
    func showDetails(gif: String) {
        let detailsViewController = DetailsViewController(gif: gif)
        navigationController.show(detailsViewController, sender: nil)
    }
}
