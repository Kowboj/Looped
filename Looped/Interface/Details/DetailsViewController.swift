import UIKit
import RxSwift

final class DetailsViewController: ViewController {
    
    // MARK: - Properties
    private let detailsView = DetailsView()
    private let gif: String
    weak var popularFlowDelegate: PopularViewControllerFlowDelegate?
    weak var userFlowDelegate: UserViewControllerFlowDelegate?
    
    // MARK: - Initializers
    init(gif: String) {
        self.gif = gif
        super.init()
    }
    
    // MARK: - Overrides
    override func loadView() {
        view = detailsView
    }
    
    override func setupProperties() {
        super.setupProperties()
        detailsView.detailsInfoLabel.text = gif
    }
}
