import UIKit

protocol CreateViewControllerFlowDelegate: class, DetailsShowable {}

final class CreateViewController: ViewController {
    
    // MARK: - Properties
    private let createView = CreateView()
    weak var flowDelegate: CreateViewControllerFlowDelegate?
    
    // MARK: - Overrides
    override func loadView() {
        super.loadView()
        view = createView
    }
}
