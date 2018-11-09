import UIKit

class TabView: View {
    
    private(set) lazy var customTabInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Custom tab bar here"
        label.textAlignment = .center
        return label
    }()
    
    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        [customTabInfoLabel].forEach(addSubview)
    }
    
    override func setupLayoutConstraints() {
        super.setupViewHierarchy()
        customTabInfoLabel.centerInSuperview(size: CGSize(width: 300, height: 30))
    }
}
