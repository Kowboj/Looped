import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    let popularRootViewController = PopularFlowController().rootViewController
    let userRootViewController = UserFlowController().rootViewController
    let createRootViewController = CreateFlowController().rootViewController
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
        popularRootViewController.tabBarItem = tabBarItem(at: 0)
        userRootViewController.tabBarItem = tabBarItem(at: 1)
        createRootViewController.tabBarItem = tabBarItem(at: 2)
    }
    
    private func setupViewControllers() {
        viewControllers = [popularRootViewController, userRootViewController, createRootViewController]
    }
    
    private func tabBarItem(at index: Int) -> UITabBarItem {
        let image = UIImage(named: tabBarItemImages[index])?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        return UITabBarItem(title: nil, image: image, tag: index)
    }
}
