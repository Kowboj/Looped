import UIKit

final class CreateFlowController: FlowController {
    
    let rootControllersFactory = CreateFlowControllerFactory()
    lazy var rootViewController: UINavigationController = {
        navigationController.viewControllers = [rootControllersFactory.buildCreateViewController(delegate: self)]
        
        return navigationController
    }()
    
    private lazy var navigationController: UINavigationController = {
        return UINavigationController()
    }()
    
    init() {
        navigationController.show(rootViewController, sender: nil)
    }
}

extension CreateFlowController: CreateViewControllerFlowDelegate {
    func showDetails(gif: String) {
        let detailsViewController = DetailsViewController(gif: gif)
        navigationController.show(detailsViewController, sender: nil)
    }
}
