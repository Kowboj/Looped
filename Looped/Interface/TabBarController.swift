import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    let popularRootViewController = PopularFlowController(navigationController: UINavigationController(), rootViewController: PopularViewController()).root
    let userRootViewController = UserFlowController(navigationController: UINavigationController(), rootViewController: UserViewController()).root
    let createRootViewController = CreateFlowController(navigationController: UINavigationController(), rootViewController: CreateViewController()).root
    
    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
        popularRootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.featured, tag: 0)
        userRootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.contacts, tag: 1)
        createRootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.more, tag: 2)
        viewControllers = [popularRootViewController, userRootViewController, createRootViewController]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
