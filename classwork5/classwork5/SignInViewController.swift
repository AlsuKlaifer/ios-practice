import UIKit

class SignInViewController: UIViewController {
    private let username: String = "alsu"
    private let password: String = "1234"
    
    private lazy var loginTF: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Username"
        return textField
    }()
    
    private lazy var passwordTF: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        
        var attributes = AttributeContainer()
        attributes.font = UIFont.systemFont(ofSize: 20)
         
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.attributedTitle = AttributedString("Sign in", attributes: attributes)
        buttonConfiguration.baseForegroundColor = .darkGray
        return UIButton(
            configuration: buttonConfiguration,
            primaryAction: UIAction { [unowned self] _ in
                if (loginTF.text?.lowercased() == username && passwordTF.text == password){
                    let mainTBC: MainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
                    mainTBC.modalPresentationStyle = .fullScreen
                    present(mainTBC, animated: true)
                    
                    let navVC = mainTBC.viewControllers![0] as! UINavigationController
                    let homeVC = navVC.topViewController as! HomeViewController
                    homeVC.username = loginTF.text!
                    
                    let navVC2 = mainTBC.viewControllers![1] as! UINavigationController
                    let exitVC = navVC2.topViewController as! ExitViewController
                    exitVC.username = loginTF.text!
            }
        else{
            let alert = UIAlertController(title: "Error", message: "Wrong username or password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                         NSLog("The \"OK\" alert occured.")
                         }))
            self.present(alert, animated: true, completion: nil)
        }
    })
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loginButton)
        setConstraint()
    }
    
    private func setConstraint(){
        
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 20
        
        view.addSubview(stackview)
        stackview.addArrangedSubview(loginTF)
        stackview.addArrangedSubview(passwordTF)
        
        stackview.translatesAutoresizingMaskIntoConstraints = false
        loginTF.translatesAutoresizingMaskIntoConstraints = false
        passwordTF.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            stackview.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            stackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            loginButton.topAnchor.constraint(equalTo: stackview.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
    }
}

