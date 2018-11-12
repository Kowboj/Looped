import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    let popularRootViewController = PopularFlowController().rootViewController
    let userRootViewController = UserFlowController().rootViewController
    let createRootViewController = CreateFlowController().rootViewController
    
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
        let popularImage = UIImage(named: "barItemPopular")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        popularRootViewController.tabBarItem = UITabBarItem(title: "Featured", image: popularImage, tag: 0)
        
        let userImage = UIImage(named: "barItemUser")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        userRootViewController.tabBarItem = UITabBarItem(title: nil, image: userImage, tag: 1)

        let createImage = UIImage(named: "barItemCreate")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        createRootViewController.tabBarItem = UITabBarItem(title: nil, image: createImage, tag: 2)
    }
    
    private func setupViewControllers() {
        viewControllers = [popularRootViewController, userRootViewController, createRootViewController]
    }
}
