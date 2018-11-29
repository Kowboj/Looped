import UIKit

class ViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("Implementation unavailable")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupProperties()
        setupBindings()
    }
    
    func setupNavigationItem() {}
    func setupProperties() {}
    func setupBindings() {}

}
