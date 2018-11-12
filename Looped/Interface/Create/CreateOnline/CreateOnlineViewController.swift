import UIKit

final class CreateOnlineViewController: ViewController {
    
    // MARK: - Properties
    private let createOnlineView = CreateOnlineView()
    
    // MARK: - Overrides
    override func loadView() {
        view = createOnlineView
    }
}
