import UIKit

final class GifCell: TableViewCell {
    
    private(set) lazy var gifImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.init(white: 0.9, alpha: 0.9)
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        [gifImageView].forEach(addSubview)
    }
    
    override func setupProperties() {
        super.setupProperties()
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()
        gifImageView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: -10), size: CGSize.zero)
    }
}
