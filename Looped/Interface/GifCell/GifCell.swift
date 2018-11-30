import UIKit
import SwiftyGif

protocol GifPlayable {
    func openGifFrom(url: URL)
}

final class GifCell: TableViewCell {
    
    private(set) lazy var gifImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.init(white: 0.9, alpha: 0.9).cgColor
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "AmericanTypewriter", size: 20)
        label.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        return label
    }()
    
    private(set) lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "AmericanTypewriter", size: 26)
        label.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        return label
    }()
    
    // MARK: - Overrides

    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        [gifImageView, titleLabel, likesLabel].forEach(addSubview)
    }
    
    override func setupProperties() {
        super.setupProperties()
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()
        anchor(top: nil, leading: nil, trailing: nil, bottom: nil, padding: UIEdgeInsets.zero, size: CGSize(width: 0, height: 200))
        gifImageView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: -10), size: CGSize.zero)
        titleLabel.anchor(top: nil, leading: gifImageView.leadingAnchor, trailing: gifImageView.trailingAnchor, bottom: gifImageView.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 10, bottom: -10, right: -10))
        likesLabel.anchor(top: gifImageView.topAnchor, leading: gifImageView.leadingAnchor, trailing: nil, bottom: nil, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0))
    }
}

extension GifCell: GifPlayable {
    func openGifFrom(url: URL) {
        gifImageView.setGifFromURL(url)
    }
}
