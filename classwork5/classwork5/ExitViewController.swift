import UIKit

class ExitViewController: UIViewController {
    var username = ""
    
    private var helloLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private lazy var signOutButton: UIButton = {
        var attributes = AttributeContainer()
        attributes.font = UIFont.systemFont(ofSize: 20)
        
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.attributedTitle = AttributedString("Sign out", attributes: attributes)
        buttonConfiguration.baseBackgroundColor = .systemGray
        buttonConfiguration.cornerStyle = .large
        return UIButton(
            configuration: buttonConfiguration,
            primaryAction: UIAction { [unowned self] _ in
                guard let signInVC = storyboard?.instantiateViewController(withIdentifier: "SignInVC") as? SignInViewController else {return}
                signInVC.modalPresentationStyle = .fullScreen
                present(signInVC, animated: true)
            })
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helloLabel.text = "Hello, \(username)!"
        
        setSubviews(helloLabel, signOutButton)
        setConstraint()
    }
    
    private func setSubviews(_ subview: UIView...) {
        subview.forEach({view.addSubview($0)})
    }
    
    private func setConstraint(){
        
        helloLabel.translatesAutoresizingMaskIntoConstraints = false
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            helloLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            signOutButton.topAnchor.constraint(equalTo: helloLabel.bottomAnchor, constant: 30),
            signOutButton.centerXAnchor.constraint(equalTo: helloLabel.centerXAnchor, constant: 0),
            signOutButton.widthAnchor.constraint(equalToConstant: 246),
            signOutButton.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
}
