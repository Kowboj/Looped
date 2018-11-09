import UIKit

final class PopularFlowController: FlowController {

    let rootControllersFactory = PopularFlowControllerFactory()
    lazy var rootViewController: UINavigationController = {
        navigationController.viewControllers = [rootControllersFactory.buildPopularViewController(delegate: self)]
        
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
        let detailsViewController = DetailsViewController(gif: gif)
        navigationController.show(detailsViewController, sender: nil)
    }
}
