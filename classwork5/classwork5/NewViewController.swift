import UIKit

class NewViewController: UIViewController {

    private var pageNumber = 1
    private var pageLabel: UILabel = {
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
                newVC.pageNumber = pageNumber + 1
                navigationController?.pushViewController(newVC, animated: true)
            })
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageLabel.text = "Catalog. Page: \(pageNumber)"
        
        setSubviews(pageLabel, browseButton)
        setConstraint()
    }
    
    private func setSubviews(_ subview: UIView...) {
        subview.forEach({view.addSubview($0)})
    }
    
    private func setConstraint(){
        
        pageLabel.translatesAutoresizingMaskIntoConstraints = false
        browseButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            pageLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            browseButton.topAnchor.constraint(equalTo: pageLabel.bottomAnchor, constant: 30),
            browseButton.centerXAnchor.constraint(equalTo: pageLabel.centerXAnchor, constant: 0),
            browseButton.widthAnchor.constraint(equalToConstant: 246),
            browseButton.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
}
