protocol UserFlowControllerFactoryProtocol {
    func buildUserViewController(delegate: UserViewControllerFlowDelegate) -> UserViewController
    func buildDetailsViewController(gif: String, delegate: UserViewControllerFlowDelegate) -> DetailsViewController
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
}
