protocol PopularFlowControllerFactoryProtocol {
    func buildPopularViewController(delegate: PopularViewControllerFlowDelegate) -> PopularViewController
    func buildDetailsViewController(gif: String, delegate: PopularViewControllerFlowDelegate) -> DetailsViewController
}

final class  PopularFlowControllerFactory: PopularFlowControllerFactoryProtocol {
    
    func buildPopularViewController(delegate: PopularViewControllerFlowDelegate) -> PopularViewController {
        let viewController = PopularViewController()
        viewController.flowDelegate = delegate
        return viewController
    }
    
    func buildDetailsViewController(gif: String, delegate: PopularViewControllerFlowDelegate) -> DetailsViewController {
        let viewController = DetailsViewController(gif: gif)
        viewController.popularFlowDelegate = delegate
        return viewController
    }
}
