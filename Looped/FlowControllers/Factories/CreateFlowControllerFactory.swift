protocol CreateFlowControllerFactoryProtocol {
    func buildCreateViewController(delegate: CreateViewControllerFlowDelegate) -> CreateViewController
}

final class  CreateFlowControllerFactory: CreateFlowControllerFactoryProtocol {
    
    private let applicationDependencies: ApplicationDependenciesProvider
    
    init(applicationDependencies: ApplicationDependenciesProvider) {
        self.applicationDependencies = applicationDependencies
    }
    
    func buildCreateViewController(delegate: CreateViewControllerFlowDelegate) -> CreateViewController {
        let viewController = CreateViewController()
        
        viewController.flowDelegate = delegate
        return viewController
    }
}
