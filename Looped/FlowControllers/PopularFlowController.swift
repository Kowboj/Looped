import UIKit

final class PopularFlowController: FlowController {
    typealias RootViewController = UINavigationController
    
    let controllersFactory = PopularFlowControllerFactory()
    lazy var rootViewController: UINavigationController = {
        navigationController.viewControllers = [controllersFactory.buildPopularViewController(delegate: self)]
        
        return navigationController
    }()
    
    private lazy var navigationController: UINavigationController = {
        return UINavigationController()
    }()
    
    init() {
        navigationController.show(rootViewController, sender: nil)
    }
}

extension PopularFlowController: PopularViewControllerFlowDelegate {
    func showDetails(gif: String) {
        navigationController.pushViewController(controllersFactory.buildDetailsViewController(gif: gif, delegate: self), animated: true)
    }
}
