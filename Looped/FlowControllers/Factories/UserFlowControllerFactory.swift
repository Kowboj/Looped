protocol UserFlowControllerFactoryProtocol {
    func buildUserViewController(delegate: UserViewControllerFlowDelegate) -> UserViewController
    func buildDetailsViewController(gif: GifViewModel) -> DetailsViewController
    func buildLoginViewController() -> LoginViewController
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
    
    func buildDetailsViewController(gif: GifViewModel) -> DetailsViewController {
        
        let viewModel = DetailsViewModel(gif: gif)
        let viewController = DetailsViewController(viewModel: viewModel)
        
        return viewController
    }
    
    func buildLoginViewController() -> LoginViewController {
        
        let service = LoginService(apiClient: applicationDependencies.apiClient)
        let viewModel = LoginViewModel(service: service, sessionProvider: applicationDependencies.sessionProvider)
        let viewController = LoginViewController(viewModel: viewModel)

        return viewController
    }
}
