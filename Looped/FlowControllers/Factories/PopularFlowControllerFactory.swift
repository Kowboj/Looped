protocol PopularFlowControllerFactoryProtocol {
    func buildPopularViewController(delegate: PopularViewControllerFlowDelegate) -> PopularViewController
}

final class  PopularFlowControllerFactory: PopularFlowControllerFactoryProtocol {
    func buildPopularViewController(delegate: PopularViewControllerFlowDelegate) -> PopularViewController {
        let viewController = PopularViewController()
        
        viewController.flowDelegate = delegate
        return viewController
    }
}
