import UIKit


final class UserFlowController: FlowController {

    init(controllersFactory: UserFlowControllerFactoryProtocol) {
        self.controllersFactory = controllersFactory
    }
    
    private let controllersFactory: UserFlowControllerFactoryProtocol
    
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
        navigationController.pushViewController(controllersFactory.buildDetailsViewController(gif: gif), animated: true)
    }
    
    func presentLogin(delegate: LoginViewControllerDelegate) {
        navigationController.present(controllersFactory.buildLoginViewController(delegate: delegate), animated: true, completion: nil)
    }
    
    func dismissLogin() {
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    func presentRegister() {
        navigationController.present(controllersFactory.buildRegisterViewController(), animated: true, completion: nil)
    }
}
