protocol PopularFlowControllerFactoryProtocol {
    func buildPopularViewController(delegate: PopularViewControllerFlowDelegate) -> PopularViewController
    func buildDetailsViewController(gif: GifViewModel) -> DetailsViewController
}

final class PopularFlowControllerFactory: PopularFlowControllerFactoryProtocol {

    init(applicationDependencies: ApplicationDependenciesProvider) {
        self.applicationDependencies = applicationDependencies
    }
    
    private let applicationDependencies: ApplicationDependenciesProvider
    
    func buildPopularViewController(delegate: PopularViewControllerFlowDelegate) -> PopularViewController {
        
        let service = ReactionTagsService(apiClient: applicationDependencies.apiClient)
        let viewModel = PopularViewModel(service: service)
        let viewController = PopularViewController(viewModel: viewModel)
        viewController.flowDelegate = delegate
        
        return viewController
    }
    
    func buildDetailsViewController(gif: GifViewModel) -> DetailsViewController {
        
        let detailsViewModel = DetailsViewModel(gif: gif)
        let viewController = DetailsViewController(viewModel: detailsViewModel)
        
        return viewController
    }
}
