import UIKit

class HomeViewController: UIViewController {

    var username = ""
    
    private var helloLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private lazy var browseButton: UIButton = {
        var attributes = AttributeContainer()
        attributes.font = UIFont.systemFont(ofSize: 20)
        
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.attributedTitle = AttributedString("Browse catalog", attributes: attributes)
        buttonConfiguration.baseBackgroundColor = .systemGray
        buttonConfiguration.cornerStyle = .large
        return UIButton(
            configuration: buttonConfiguration,
            primaryAction: UIAction { [unowned self] _ in
                guard let newVC = storyboard?.instantiateViewController(withIdentifier: "NewVC") as? NewViewController else {return}
                navigationController?.pushViewController(newVC, animated: true)
            })
        }()
    
    private lazy var showCatButton: UIButton = {
        var attributes = AttributeContainer()
        attributes.font = UIFont.systemFont(ofSize: 20)
        
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.attributedTitle = AttributedString("Show Cats", attributes: attributes)
        buttonConfiguration.baseBackgroundColor = .systemGray
        buttonConfiguration.cornerStyle = .large
        return UIButton(
            configuration: buttonConfiguration,
            primaryAction: UIAction { [unowned self] _ in
                guard let catsVC = storyboard?.instantiateViewController(withIdentifier: "CatsVC") as? CatsViewController else {return}
                present(catsVC, animated: true)
            })
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helloLabel.text = "Hello, \(username)!"
        
        view.addSubview(helloLabel)
        setConstraint()
    }
    
    private func setConstraint(){
        
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 20
        
        view.addSubview(stackview)
        stackview.addArrangedSubview(browseButton)
        stackview.addArrangedSubview(showCatButton)
        
        stackview.translatesAutoresizingMaskIntoConstraints = false
        browseButton.translatesAutoresizingMaskIntoConstraints = false
        showCatButton.translatesAutoresizingMaskIntoConstraints = false
        helloLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            helloLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            stackview.topAnchor.constraint(equalTo: helloLabel.bottomAnchor, constant: 30),
            stackview.centerXAnchor.constraint(equalTo: helloLabel.centerXAnchor, constant: 0),
            stackview.widthAnchor.constraint(equalToConstant: 246),
            browseButton.heightAnchor.constraint(equalToConstant: 75),
            showCatButton.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
}
