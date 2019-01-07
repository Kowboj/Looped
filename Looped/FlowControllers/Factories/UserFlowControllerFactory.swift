protocol UserFlowControllerFactoryProtocol {
    func buildUserViewController(delegate: UserViewControllerFlowDelegate) -> UserViewController
    func buildDetailsViewController(gif: GifViewModel) -> DetailsViewController
    func buildLoginViewController(delegate: LoginViewControllerDelegate) -> LoginViewController
    func buildRegisterViewController() -> RegisterViewController
}

final class  UserFlowControllerFactory: UserFlowControllerFactoryProtocol {
    
    init(applicationDependencies: ApplicationDependenciesProvider) {
        self.applicationDependencies = applicationDependencies
    }
    
    private let applicationDependencies: ApplicationDependenciesProvider
    
    func buildUserViewController(delegate: UserViewControllerFlowDelegate) -> UserViewController {
        
        let service = UserGifsService(apiClient: applicationDependencies.apiClient)
        let viewModel = UserViewModel(service: service, sessionProvider: applicationDependencies.sessionProvider)
        let viewController = UserViewController(userViewModel: viewModel)
        viewController.flowDelegate = delegate
        
        return viewController
    }
    
    func buildDetailsViewController(gif: GifViewModel) -> DetailsViewController {
        
        let viewModel = DetailsViewModel(gif: gif)
        let viewController = DetailsViewController(viewModel: viewModel)
        
        return viewController
    }
    
    func buildLoginViewController(delegate: LoginViewControllerDelegate) -> LoginViewController {
        
        let service = LoginService(apiClient: applicationDependencies.apiClient)
        let viewModel = LoginViewModel(service: service, sessionProvider: applicationDependencies.sessionProvider)
        let viewController = LoginViewController(viewModel: viewModel)
        viewController.delegate = delegate
        
        return viewController
    }
    
    func buildRegisterViewController() -> RegisterViewController {
        
        let service = RegisterService(apiClient: applicationDependencies.apiClient)
        let viewModel = RegisterViewModel(service: service, sessionProvider: applicationDependencies.sessionProvider)
        let viewController = RegisterViewController(viewModel: viewModel)
        
        return viewController
    }
}
