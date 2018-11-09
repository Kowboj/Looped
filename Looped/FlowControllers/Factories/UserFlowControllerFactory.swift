protocol UserFlowControllerFactoryProtocol {
    func buildUserViewController(delegate: UserViewControllerFlowDelegate) -> UserViewController
}

final class  UserFlowControllerFactory: UserFlowControllerFactoryProtocol {
    func buildUserViewController(delegate: UserViewControllerFlowDelegate) -> UserViewController {
        let viewController = UserViewController()
        
        viewController.flowDelegate = delegate
        return viewController
    }
}
