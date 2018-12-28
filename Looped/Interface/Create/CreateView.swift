import UIKit

final class CreateView: View {
    
    private(set) lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["1", "2"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.tintColor = UIColor.init(white: 0.9, alpha: 0.9)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private(set) lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        [segmentedControl, containerView].forEach(addSubview)
    }
    
    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()
        segmentedControl.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil, padding: UIEdgeInsets(top: 300, left: 10, bottom: 0, right: -10), size: CGSize(width: 0, height: 0))
        containerView.anchor(top: segmentedControl.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, padding: UIEdgeInsets.zero, size: CGSize.zero)
    }
}
