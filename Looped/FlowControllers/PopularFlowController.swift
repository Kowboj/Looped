import UIKit

final class PopularFlowController: FlowController {
    typealias RootViewController = UINavigationController

    init(controllersFactory: PopularFlowControllerFactoryProtocol) {
        self.controllersFactory = controllersFactory
    }
    
    private let controllersFactory: PopularFlowControllerFactoryProtocol

    lazy var rootViewController: UINavigationController = {
        navigationController.viewControllers = [controllersFactory.buildPopularViewController(delegate: self)]
        return navigationController
    }()
    
    private lazy var navigationController: UINavigationController = {
        return UINavigationController()
    }()
}

extension PopularFlowController: PopularViewControllerFlowDelegate {
    func showDetails(gif: GifViewModel) {
        navigationController.pushViewController(controllersFactory.buildDetailsViewController(gif: gif), animated: true)
    }
}
