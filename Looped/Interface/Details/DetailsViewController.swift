import UIKit

final class DetailsViewController: ViewController {
    
    // MARK: - Properties
    private let detailsView = DetailsView()
    private let gif: String
    
    // MARK: - Initializers
    init(gif: String) {
        self.gif = gif
        super.init()
    }
    
    // MARK: - Private
    override func loadView() {
        view = detailsView
    }
    
    override func setupProperties() {
        detailsView.detailsInfoLabel.text = gif
    }
}
