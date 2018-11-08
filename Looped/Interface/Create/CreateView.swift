import UIKit

final class CreateView: TabView {
    
    private(set) lazy var userInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Third tab - Create - for not logged users ('Create' click asks for logging).\n\nIn the top there's profile image and some info.\n\nIn the middle - a custom tab bar with two tabs - User Feed (sent by user), and User Favorites (liked by user)"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        [userInfoLabel].forEach(addSubview)
    }
    
    override func setupProperties() {
        super.setupProperties()
        backgroundColor = .yellow
    }
    
    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()
        userInfoLabel.anchor(top: customTabInfoLabel.bottomAnchor, leading: customTabInfoLabel.leadingAnchor, trailing: customTabInfoLabel.trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor)
    }
}
