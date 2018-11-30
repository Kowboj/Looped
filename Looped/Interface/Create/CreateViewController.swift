import UIKit

protocol CreateViewControllerFlowDelegate: class {
    func showDetails(gif: GifViewModel)
}

final class CreateViewController: ViewController {
    
    // MARK: - Properties
    private let createView = CreateView()
    weak var flowDelegate: CreateViewControllerFlowDelegate?
    let createOnlineViewController = CreateOnlineViewController()
    let createLibraryViewController = CreateLibraryViewController()
    
    // MARK: - Overrides
    
    override func loadView() {
        view = createView
    }
    
    override func setupNavigationItem() {
        super.setupNavigationItem()
        navigationItem.title = "Create GIF"
    }
    
    override func setupProperties() {
        super.setupProperties()
        setupSegmentedControl()
        changeContainerViewController(to: 0)
    }
    
    // MARK: - Private
    
    private func setupSegmentedControl() {
        createView.segmentedControl.setTitle("URL", forSegmentAt: 0)
        createView.segmentedControl.setTitle("Library", forSegmentAt: 1)
        createView.segmentedControl.addTarget(self, action: #selector(segmentedTapped), for: .valueChanged)
    }
    
    private func changeContainerViewController(to index: Int) {
        switch index {
        case 0: // Create from URL
            removeContainer(viewController: createLibraryViewController)
            addContainer(viewController: createOnlineViewController)
        case 1: // Create from Library
            removeContainer(viewController: createOnlineViewController)
            addContainer(viewController: createLibraryViewController)
        default:
            break
        }
    }
    
    private func addContainer(viewController: UIViewController) {
        guard let view = viewController.view else { return }
        addChild(viewController)
        view.translatesAutoresizingMaskIntoConstraints = false
        createView.containerView.addSubview(view)
        view.centerInSuperview(padding: 10)
        createOnlineViewController.didMove(toParent: self)
    }
    
    private func removeContainer(viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    @objc private func segmentedTapped(sender: UISegmentedControl) {
        changeContainerViewController(to: sender.selectedSegmentIndex)
    }
}
