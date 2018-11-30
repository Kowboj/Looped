import UIKit

final class CreateFlowController: FlowController {
    
    let rootControllersFactory = CreateFlowControllerFactory()
    lazy var rootViewController: UINavigationController = {
        navigationController.viewControllers = [rootControllersFactory.buildCreateViewController(delegate: self)]
        
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
