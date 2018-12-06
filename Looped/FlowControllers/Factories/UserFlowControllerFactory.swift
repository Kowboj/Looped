protocol UserFlowControllerFactoryProtocol {
    func buildUserViewController(delegate: UserViewControllerFlowDelegate) -> UserViewController
    func buildDetailsViewController(gif: GifViewModel, delegate: UserViewControllerFlowDelegate) -> DetailsViewController
    func buildLoginViewController(delegate: UserViewControllerFlowDelegate) -> LoginViewController
}

final class  UserFlowControllerFactory: UserFlowControllerFactoryProtocol {
    
    private let applicationDependencies: ApplicationDependenciesProvider
    
    init(applicationDependencies: ApplicationDependenciesProvider) {
        self.applicationDependencies = applicationDependencies
    }
    
    func buildUserViewController(delegate: UserViewControllerFlowDelegate) -> UserViewController {
        
        let service = ReactionTagsService(apiClient: applicationDependencies.apiClient)
        let viewModel = UserViewModel(service: service)
        let viewController = UserViewController(userViewModel: viewModel)
        viewController.flowDelegate = delegate
        
        return viewController
    }
    
    func buildDetailsViewController(gif: GifViewModel, delegate: UserViewControllerFlowDelegate) -> DetailsViewController {
        
        let viewModel = DetailsViewModel(gif: gif)
        let viewController = DetailsViewController(viewModel: viewModel)
        
        return viewController
    }
    
    func buildLoginViewController(delegate: UserViewControllerFlowDelegate) -> LoginViewController {
        let viewController = LoginViewController()

        return viewController
    }
}
