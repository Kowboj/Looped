protocol CreateFlowControllerFactoryProtocol {
    func buildCreateViewController(delegate: CreateViewControllerFlowDelegate) -> CreateViewController
}

final class  CreateFlowControllerFactory: CreateFlowControllerFactoryProtocol {
    
    init(applicationDependencies: ApplicationDependenciesProvider) {
        self.applicationDependencies = applicationDependencies
    }
    
    private let applicationDependencies: ApplicationDependenciesProvider
    
    func buildCreateViewController(delegate: CreateViewControllerFlowDelegate) -> CreateViewController {
        
        let viewController = CreateViewController()
        viewController.flowDelegate = delegate
        
        return viewController
    }
}
