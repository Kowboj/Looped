import UIKit

final class UserView: TabView {
    
    private(set) lazy var userInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Second tab - User - requires logging.\n\nIn the top there's profile image and some info.\n\nIn the middle - a custom tab bar with two tabs - User Feed (sent by user), and User Favorites (liked by user) - shown below"
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
        backgroundColor = UIColor.orange
    }
    
    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()
        userInfoLabel.anchor(top: customTabInfoLabel.bottomAnchor, leading: customTabInfoLabel.leadingAnchor, trailing: customTabInfoLabel.trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor)
    }
}
