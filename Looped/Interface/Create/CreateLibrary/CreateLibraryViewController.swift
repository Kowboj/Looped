import UIKit

final class CreateLibraryViewController: ViewController {
    
    // MARK: - Properties
    let createLibraryView = CreateLibraryView()
    
    // MARK: - Overrides
    override func loadView() {
        view = createLibraryView
    }
}
