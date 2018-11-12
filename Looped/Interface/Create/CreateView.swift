import UIKit

final class CreateView: TabView {
    
    private(set) lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        [containerView].forEach(addSubview)
    }
    
    override func setupProperties() {
        super.setupProperties()
    }
    
    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()
        containerView.anchor(top: segmentedControl.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, padding: UIEdgeInsets.zero, size: CGSize.zero)
    }
}
