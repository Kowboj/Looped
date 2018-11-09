import UIKit

class View: UIView {
    
    init() {
        super.init(frame: .zero)
        setupViewHierarchy()
        setupProperties()
        setupLayoutConstraints()
    }
    
    override static var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    func setupViewHierarchy() {}
    func setupProperties() {}
    func setupLayoutConstraints() {}
    
    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
