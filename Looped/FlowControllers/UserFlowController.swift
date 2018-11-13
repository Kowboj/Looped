import UIKit

final class UserFlowController: FlowController {
    
    let controllersFactory = UserFlowControllerFactory()
    lazy var rootViewController: UINavigationController = {
        navigationController.viewControllers = [controllersFactory.buildUserViewController(delegate: self)]
        
        return navigationController
    }()
    
    private lazy var navigationController: UINavigationController = {
        return UINavigationController()
    }()
}

extension UserFlowController: UserViewControllerFlowDelegate {
    func showDetails(gif: String) {
        navigationController.pushViewController(controllersFactory.buildDetailsViewController(gif: gif, delegate: self), animated: true)
    }
}
