protocol PopularFlowControllerFactoryProtocol {
    func buildPopularViewController(delegate: PopularViewControllerFlowDelegate) -> PopularViewController
    func buildDetailsViewController(gif: String, delegate: PopularViewControllerFlowDelegate) -> DetailsViewController
}

final class  PopularFlowControllerFactory: PopularFlowControllerFactoryProtocol {
    
    func buildPopularViewController(delegate: PopularViewControllerFlowDelegate) -> PopularViewController {
        let service = ReactionTagsService(apiClient: DefaultAPIClient())
        let viewModel = PopularViewModel(service: service)
        let viewController = PopularViewController(viewModel: viewModel)
        viewController.flowDelegate = delegate
        return viewController
    }
    
    func buildDetailsViewController(gif: String, delegate: PopularViewControllerFlowDelegate) -> DetailsViewController {
        let viewController = DetailsViewController(gif: gif)
        viewController.popularFlowDelegate = delegate
        return viewController
    }
}
