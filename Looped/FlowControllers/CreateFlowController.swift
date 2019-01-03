import UIKit

final class CreateFlowController: FlowController {
    
    private let controllersFactory: CreateFlowControllerFactoryProtocol
    
    init(controllersFactory: CreateFlowControllerFactoryProtocol) {
        self.controllersFactory = controllersFactory
    }
    
    lazy var rootViewController: UINavigationController = {
        navigationController.viewControllers = [controllersFactory.buildCreateViewController(delegate: self)]
        
        return navigationController
    }()
    
    private lazy var navigationController: UINavigationController = {
        return UINavigationController()
    }()
}

extension CreateFlowController: CreateViewControllerFlowDelegate {
    func showDetails(gif: GifViewModel) {
        let detailsViewModel = DetailsViewModel(gif: gif)
        let detailsViewController = DetailsViewController(viewModel: detailsViewModel)
        navigationController.show(detailsViewController, sender: nil)
    }
}
