protocol UserFlowControllerFactoryProtocol {
    func buildUserViewController(delegate: UserViewControllerFlowDelegate) -> UserViewController
    func buildDetailsViewController(gif: String, delegate: UserViewControllerFlowDelegate) -> DetailsViewController
    func buildLoginViewController(delegate: UserViewControllerFlowDelegate) -> LoginViewController
}

final class  UserFlowControllerFactory: UserFlowControllerFactoryProtocol {
    
    func buildUserViewController(delegate: UserViewControllerFlowDelegate) -> UserViewController {
        let viewController = UserViewController()
        
        viewController.flowDelegate = delegate
        return viewController
    }
    
    func buildDetailsViewController(gif: String, delegate: UserViewControllerFlowDelegate) -> DetailsViewController {
        let viewController = DetailsViewController(gif: gif)
        
        viewController.userFlowDelegate = delegate
        return viewController
    }
    
    func buildLoginViewController(delegate: UserViewControllerFlowDelegate) -> LoginViewController {
        let viewController = LoginViewController()
        
        viewController.userFlowDelegate = delegate
        return viewController
    }
}
