import UIKit

class UserFlowController: FlowController {
    
    let navigationController: UINavigationController
    let root: UserViewController
    
    init(navigationController: UINavigationController, rootViewController: UserViewController) {
        self.navigationController = navigationController
        root = rootViewController
        navigationController.show(rootViewController, sender: nil)
    }
}
