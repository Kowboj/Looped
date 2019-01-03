protocol TabBarControllerFactoryProtocol {
    func buildTabBarController() -> TabBarController
    func buildPopularFlowController() -> PopularFlowController
    func buildUserFlowController() -> UserFlowController
    func buildCreateFlowController() -> CreateFlowController
}

final class TabBarControllerFactory: TabBarControllerFactoryProtocol {
    
    private let popularFlowControllerFactory: PopularFlowControllerFactoryProtocol
    private let userFlowControllerFactory: UserFlowControllerFactoryProtocol
    private let createFlowControllerFactory: CreateFlowControllerFactoryProtocol
    
    init(popularFlowControllerFactory: PopularFlowControllerFactoryProtocol,
         userFlowControllerFactory: UserFlowControllerFactoryProtocol,
         createFlowControllerFactory: CreateFlowControllerFactoryProtocol) {
        self.popularFlowControllerFactory = popularFlowControllerFactory
        self.userFlowControllerFactory = userFlowControllerFactory
        self.createFlowControllerFactory = createFlowControllerFactory
    }
    
    func buildTabBarController() -> TabBarController {
        return TabBarController(controllersFactory: self)
    }
    
    func buildPopularFlowController() -> PopularFlowController {
        return PopularFlowController(controllersFactory: popularFlowControllerFactory)
    }
    
    func buildUserFlowController() -> UserFlowController {
        return UserFlowController(controllersFactory: userFlowControllerFactory)
    }
    
    func buildCreateFlowController() -> CreateFlowController {
        return CreateFlowController(controllersFactory: createFlowControllerFactory)
    }
}
