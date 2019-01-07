import UIKit

final class UserView: View {
    
    private(set) lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Logout", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont(name: "AmericanTypewriter", size: 16)
        button.setTitleColor(UIColor.init(white: 0.9, alpha: 0.9), for: UIControl.State.normal)
        button.layer.borderColor = UIColor.init(white: 0.9, alpha: 0.9).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()
    
    private(set) lazy var photoImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.init(white: 0.9, alpha: 0.9)
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private(set) lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["1", "2"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.tintColor = UIColor.init(white: 0.9, alpha: 0.9)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private(set) lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont(name: "AmericanTypewriter", size: 16)
        button.setTitleColor(UIColor.init(white: 0.9, alpha: 0.9), for: UIControl.State.normal)
        button.layer.borderColor = UIColor.init(white: 0.9, alpha: 0.9).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()
    
    private(set) lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont(name: "AmericanTypewriter", size: 16)
        button.setTitleColor(UIColor.init(white: 0.9, alpha: 0.9), for: UIControl.State.normal)
        button.layer.borderColor = UIColor.init(white: 0.9, alpha: 0.9).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.layer.borderColor = UIColor.init(white: 0.9, alpha: 0.9).cgColor
        tableView.layer.borderWidth = 1
        tableView.layer.cornerRadius = 5
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private(set) lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login to see your gifs"
        label.textColor = UIColor.init(white: 0.9, alpha: 0.9)
        label.font = UIFont(name: "AmericanTypewriter", size: 16)
        label.textAlignment = .center
        return label
    }()
    
    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        
        [logoutButton, photoImageView, segmentedControl, loginButton, registerButton, tableView, infoLabel].forEach(addSubview)
    }
    
    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()
        
        photoImageView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, trailing: nil, bottom: nil, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 0), size: CGSize(width: 100, height: 100))
        segmentedControl.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil, padding: UIEdgeInsets(top: 300, left: 10, bottom: 0, right: -10), size: CGSize(width: 0, height: 0))
        
        NSLayoutConstraint.activate([
            logoutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            logoutButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            logoutButton.widthAnchor.constraint(equalToConstant: 80),
            
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -60),
            loginButton.bottomAnchor.constraint(equalTo: segmentedControl.topAnchor, constant: -20),
            loginButton.widthAnchor.constraint(equalToConstant: 80),
            
            registerButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 60),
            registerButton.bottomAnchor.constraint(equalTo: segmentedControl.topAnchor, constant: -20),
            registerButton.widthAnchor.constraint(equalToConstant: 80),
            
            infoLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
            ])
        
        tableView.anchor(top: segmentedControl.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: -10, right: -10))
    }
}
