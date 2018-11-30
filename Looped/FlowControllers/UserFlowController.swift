import UIKit


final class UserFlowController: FlowController {

    private let controllersFactory: UserFlowControllerFactoryProtocol
    
    init(controllersFactory: UserFlowControllerFactoryProtocol) {
        self.controllersFactory = controllersFactory
    }

    
    lazy var rootViewController: UINavigationController = {
        navigationController.viewControllers = [controllersFactory.buildUserViewController(delegate: self)]
        
        return navigationController
    }()
    
    private lazy var navigationController: UINavigationController = {
        return UINavigationController()
    }()
}

extension UserFlowController: UserViewControllerFlowDelegate {

    func showDetails(gif: GifViewModel) {
        navigationController.pushViewController(controllersFactory.buildDetailsViewController(gif: gif, delegate: self), animated: true)
    }
    
    func presentLogin() {
        navigationController.present(controllersFactory.buildLoginViewController(delegate: self), animated: true, completion: nil)
    }


}
