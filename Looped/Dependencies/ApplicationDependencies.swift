import Foundation

protocol ApplicationDependenciesProvider {
    var apiClient: APIClient { get }
    var authenticationController: AuthenticationControlling { get }
    var sessionProvider: SessionProviding { get }
    var sessionStore: SessionStoring { get }
    var tabBarController: TabBarController { get }
}

final class ApplicationDependencies: ApplicationDependenciesProvider {
    lazy var apiClient: APIClient = {
        return DefaultAPIClient(authenticationController: authenticationController)
    }()

    lazy var authenticationController: AuthenticationControlling = {
        return AuthenticationController(sessionProvider: sessionProvider)
    }()

    lazy var sessionProvider: SessionProviding = {
        return SessionProvider(sessionStore: sessionStore)
    }()

    lazy var sessionStore: SessionStoring = {
        return SessionStore()
    }()

    lazy var tabBarController: TabBarController = {
        let tabBarControllerFactory = TabBarControllerFactory(
            popularFlowControllerFactory: PopularFlowControllerFactory(applicationDependencies: self),
            userFlowControllerFactory: UserFlowControllerFactory(applicationDependencies: self),
            createFlowControllerFactory: CreateFlowControllerFactory(applicationDependencies: self)
        )
        return tabBarControllerFactory.buildTabBarController()
    }()
}
