import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Properties
    private let controllersFactory: TabBarControllerFactoryProtocol
    private let tabBarItemImages = ["barItemPopular", "barItemUser", "barItemCreate"]
    
    private lazy var popularRootViewController: PopularFlowController = {
        return controllersFactory.buildPopularFlowController()
    }()
    
    private lazy var userRootViewController: UserFlowController = {
        return controllersFactory.buildUserFlowController()
    }()
    
    private lazy var createRootViewController: CreateFlowController = {
        return controllersFactory.buildCreateFlowController()
    }()
    
    // MARK: - Initializers
    
    init(controllersFactory: TabBarControllerFactoryProtocol) {
        self.controllersFactory = controllersFactory
        super.init(nibName: nil, bundle: nil)
        setupTabBarItems()
    }
    
    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func setupTabBarItems() {
        popularRootViewController.rootViewController.tabBarItem = tabBarItem(at: 0)
        userRootViewController.rootViewController.tabBarItem = tabBarItem(at: 1)
        createRootViewController.rootViewController.tabBarItem = tabBarItem(at: 2)
        viewControllers = [popularRootViewController.rootViewController, userRootViewController.rootViewController, createRootViewController.rootViewController]
    }
    
    private func tabBarItem(at index: Int) -> UITabBarItem {
        let image = UIImage(named: tabBarItemImages[index])?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        return UITabBarItem(title: nil, image: image, tag: index)
    }
}
