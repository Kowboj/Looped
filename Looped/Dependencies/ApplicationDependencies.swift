import Foundation

protocol ApplicationDependenciesProvider {
    var apiClient: APIClient { get }
    var tabBarController: TabBarController { get }
    var sessionProvider: SessionProviding { get }
    var sessionStore: SessionStoring { get }
}

final class ApplicationDependencies: ApplicationDependenciesProvider {
    lazy var apiClient: APIClient = {
        return DefaultAPIClient()
    }()

    lazy var tabBarController: TabBarController = {
        let tabBarControllerFactory = TabBarControllerFactory(
            popularFlowControllerFactory: PopularFlowControllerFactory(applicationDependencies: self),
            userFlowControllerFactory: UserFlowControllerFactory(applicationDependencies: self),
            createFlowControllerFactory: CreateFlowControllerFactory(applicationDependencies: self)
        )
        return tabBarControllerFactory.buildTabBarController()
    }()

    lazy var sessionProvider: SessionProviding = {
        return SessionProvider(sessionStore: sessionStore)
    }()

    lazy var sessionStore: SessionStoring = {
        return SessionStore()
    }()
}
