import UIKit

class CreateFlowController: FlowController {
    
    let navigationController: UINavigationController
    let root: CreateViewController
    
    init(navigationController: UINavigationController, rootViewController: CreateViewController) {
        self.navigationController = navigationController
        root = rootViewController
        navigationController.show(rootViewController, sender: nil)
    }
}
