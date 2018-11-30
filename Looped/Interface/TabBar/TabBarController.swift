import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Properties
    private let controllersFactory: TabBarControllerFactoryProtocol
    let tabBarItemImages = ["barItemPopular", "barItemUser", "barItemCreate"]
    
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
        let popularRootViewController = controllersFactory.buildPopularFlowController().rootViewController
        let userRootViewController = controllersFactory.buildUserFlowController().rootViewController
        let createRootViewController = controllersFactory.buildCreateFlowController().rootViewController
        
        popularRootViewController.tabBarItem = tabBarItem(at: 0)
        userRootViewController.tabBarItem = tabBarItem(at: 1)
        createRootViewController.tabBarItem = tabBarItem(at: 2)
        viewControllers = [popularRootViewController, userRootViewController, createRootViewController]
    }
    
    private func tabBarItem(at index: Int) -> UITabBarItem {
        let image = UIImage(named: tabBarItemImages[index])?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        return UITabBarItem(title: nil, image: image, tag: index)
    }
}
