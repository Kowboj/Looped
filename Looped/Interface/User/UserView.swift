import UIKit

final class UserView: TabView {
    
    private(set) lazy var photoImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.init(white: 0.9, alpha: 0.9)
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private(set) lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont(name: "AmericanTypewriter", size: 16)
        button.setTitleColor(.white, for: UIControl.State.normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
    
    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        [photoImageView, loginButton, tableView].forEach(addSubview)
    }
    
    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()
        photoImageView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, trailing: nil, bottom: nil, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 0), size: CGSize(width: 100, height: 100))
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: segmentedControl.topAnchor, constant: -20),
            loginButton.widthAnchor.constraint(equalToConstant: 80)
            ])
        tableView.anchor(top: segmentedControl.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, padding: UIEdgeInsets.zero, size: CGSize.zero)
    }
}
