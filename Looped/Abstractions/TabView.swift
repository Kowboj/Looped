import UIKit

class TabView: View {
    
    private(set) lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["1", "2"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.tintColor = UIColor.init(white: 0.9, alpha: 0.9)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        [segmentedControl].forEach(addSubview)
    }
    
    override func setupLayoutConstraints() {
        super.setupViewHierarchy()
        segmentedControl.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil, padding: UIEdgeInsets(top: 300, left: 10, bottom: 0, right: -10), size: CGSize(width: 0, height: 40))
    }
}
