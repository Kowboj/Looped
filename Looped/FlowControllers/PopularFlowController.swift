import UIKit

class PopularFlowController: FlowController {
    
    let root: PopularViewController
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, rootViewController: PopularViewController) {
        self.navigationController = navigationController
        root = rootViewController
        root.flowDelegate = self
        navigationController.show(rootViewController, sender: nil)
    }
}

extension PopularFlowController: PopularViewControllerFlowDelegate {}
