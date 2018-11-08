import UIKit

final class CreateViewController: ViewController {
    
    // MARK: - Properties
    private let createView = CreateView()
    
    // MARK: - Private
    override func loadView() {
        view = createView
    }
}
