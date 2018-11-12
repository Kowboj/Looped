import UIKit

protocol CreateViewControllerFlowDelegate: class, DetailsShowable {}

final class CreateViewController: ViewController {
    
    // MARK: - Actions
    @objc func segmentedTapped(sender: UISegmentedControl) {
        changeContainerViewController(to: sender.selectedSegmentIndex)
    }
    
    // MARK: - Properties
    private let createView = CreateView()
    var flowDelegate: CreateViewControllerFlowDelegate?
    let createOnlineViewController = CreateOnlineViewController()
    let createLibraryViewController = CreateLibraryViewController()
    
    // MARK: - Overrides
    override func loadView() {
        view = createView
    }
    
    override func setupNavigationItem() {
        super.setupNavigationItem()
        title = "Create GIF"
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
            removeContainer(viewController: createOnlineViewController)
            
            addChild(createOnlineViewController)
            let createOnlineView = createOnlineViewController.createOnlineView
            createOnlineView.translatesAutoresizingMaskIntoConstraints = false
            createView.containerView.addSubview(createOnlineView)
            createOnlineView.centerInSuperview(padding: 10)
            createOnlineViewController.didMove(toParent: self)
        case 1: // Create from Library
            removeContainer(viewController: createOnlineViewController)
            
            addChild(createLibraryViewController)
            let createLibraryView = createLibraryViewController.createLibraryView
            createLibraryView.translatesAutoresizingMaskIntoConstraints = false
            createView.containerView.addSubview(createLibraryView)
            createLibraryView.centerInSuperview(padding: 10)
            createLibraryViewController.didMove(toParent: self)
        default:
            break
        }
    }
    
    private func removeContainer(viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}
