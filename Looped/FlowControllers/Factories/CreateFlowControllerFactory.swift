protocol CreateFlowControllerFactoryProtocol {
    func buildCreateViewController(delegate: CreateViewControllerFlowDelegate) -> CreateViewController
}

final class  CreateFlowControllerFactory: CreateFlowControllerFactoryProtocol {
    func buildCreateViewController(delegate: CreateViewControllerFlowDelegate) -> CreateViewController {
        let viewController = CreateViewController()
        
        viewController.flowDelegate = delegate
        return viewController
    }
}
