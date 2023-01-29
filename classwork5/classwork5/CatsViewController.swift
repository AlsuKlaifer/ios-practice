import UIKit

class CatsViewController: UIViewController {

    private let catImageView = UIImageView()
    
    private lazy var closeButton: UIButton = {
        var attributes = AttributeContainer()
        attributes.font = UIFont.systemFont(ofSize: 20)
        
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.attributedTitle = AttributedString("Close", attributes: attributes)
        return UIButton(
            configuration: buttonConfiguration,
            primaryAction: UIAction { [unowned self] _ in
                self.dismiss(animated: true)
            })
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let num = Int.random(in: 1...3)
        var name: String
        switch num{
            case 1: name = "cat1"
            case 2: name = "cat2"
            case 3: name = "cat3"
            default:
                name = "cat1"
        }

        catImageView.image = UIImage(named: name)
        
        setSubviews(closeButton, catImageView)
        setConstraint()
    }
    
    private func setSubviews(_ subview: UIView...) {
        subview.forEach({view.addSubview($0)})
    }
    
    private func setConstraint(){
        
        catImageView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            closeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            catImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            catImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            catImageView.widthAnchor.constraint(equalToConstant: 370),
            catImageView.heightAnchor.constraint(equalToConstant: 370)
        ])
    }
}
