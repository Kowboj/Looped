import Foundation

protocol ApplicationDependenciesProvider {
    var apiClient: APIClient { get }
    var tabBarController: TabBarController { get }
    var sessionProvider: SessionProviding { get }
    var sessionStore: SessionStoring { get }
}

final class ApplicationDependencies: ApplicationDependenciesProvider {
    lazy var apiClient: APIClient = {
        return DefaultAPIClient(session: .shared)
    }()

    lazy var tabBarController: TabBarController = {
        return TabBarController()
    }()

    lazy var sessionProvider: SessionProviding = {
        return SessionProvider(sessionStore: sessionStore)
    }()

    lazy var sessionStore: SessionStoring = {
        return SessionStore()
    }()
}
