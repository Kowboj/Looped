import UIKit

final class LoginView: View {
    
    private(set) lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Close", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont(name: "AmericanTypewriter", size: 16)
        button.setTitleColor(.white, for: UIControl.State.normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()
    
    private(set) lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.textAlignment = .center
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private(set) lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.textAlignment = .center
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private(set) lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont(name: "AmericanTypewriter", size: 16)
        button.setTitleColor(.white, for: UIControl.State.normal)
        button.setTitleColor(.darkGray, for: UIControl.State.disabled)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        [closeButton, usernameTextField, passwordTextField, infoLabel, loginButton].forEach(addSubview)
    }
    
    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()
        
        closeButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: nil, trailing: trailingAnchor, bottom: nil, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -20), size: CGSize(width: 80, height: 0))
        
        NSLayoutConstraint.activate([
            usernameTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            usernameTextField.widthAnchor.constraint(equalToConstant: 200),
            ])
        
        passwordTextField.anchor(top: usernameTextField.bottomAnchor, leading: usernameTextField.leadingAnchor, trailing: usernameTextField.trailingAnchor, bottom: nil, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0), size: CGSize(width: 200, height: 40))
        
        infoLabel.anchor(top: nil, leading: leadingAnchor, trailing: trailingAnchor, bottom: usernameTextField.topAnchor, padding: UIEdgeInsets(top: 0, left: 40, bottom: 20, right: -40), size: CGSize(width: 0, height: 100))
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.widthAnchor.constraint(equalToConstant: 80),
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
}
