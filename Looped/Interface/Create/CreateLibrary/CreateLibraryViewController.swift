import UIKit

final class CreateLibraryViewController: ViewController {
    
    // MARK: - Properties
    
    private let createLibraryView = CreateLibraryView()
    
    // MARK: - Overrides
    
    override func loadView() {
        view = createLibraryView
    }
}
