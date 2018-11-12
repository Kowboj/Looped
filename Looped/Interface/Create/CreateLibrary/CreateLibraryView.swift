import UIKit

final class CreateLibraryView: View {
    
    private(set) lazy var testLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create GIF from library"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        [testLabel].forEach(addSubview)
    }
    
    override func setupProperties() {
        super.setupProperties()
        backgroundColor = UIColor.init(white: 0.7, alpha: 0.9)
        layer.cornerRadius = 5
    }
    
    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()
        testLabel.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor)
    }
}

