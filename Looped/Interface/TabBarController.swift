import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    let popularRootViewController = PopularFlowController().rootViewController
    let userRootViewController = UserFlowController().rootViewController
    let createRootViewController = CreateFlowController().rootViewController
    
    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
        popularRootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.featured, tag: 0)
        userRootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.contacts, tag: 1)
        createRootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.more, tag: 2)
        viewControllers = [popularRootViewController, userRootViewController, createRootViewController]
    }
    
    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
