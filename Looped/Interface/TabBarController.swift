import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    let popularRootViewController = PopularFlowController()
    let userRootViewController = UserFlowController()
    let createRootViewController = CreateFlowController()
    let tabBarItemImages = ["barItemPopular", "barItemUser", "barItemCreate"]
    
    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
        setupTabBarItems()
        setupViewControllers()
    }
    
    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func setupTabBarItems() {
        popularRootViewController.rootViewController.tabBarItem = tabBarItem(at: 0)
        userRootViewController.rootViewController.tabBarItem = tabBarItem(at: 1)
        createRootViewController.rootViewController.tabBarItem = tabBarItem(at: 2)
    }
    
    private func setupViewControllers() {
        viewControllers = [popularRootViewController.rootViewController, userRootViewController.rootViewController, createRootViewController.rootViewController]
    }
    
    private func tabBarItem(at index: Int) -> UITabBarItem {
        let image = UIImage(named: tabBarItemImages[index])?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        return UITabBarItem(title: nil, image: image, tag: index)
    }
}
