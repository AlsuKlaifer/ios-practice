import UIKit

class HomePageViewController: UIViewController {

    var username = ""
    @IBOutlet private var browseCatalogButton: UIButton!
    @IBOutlet private var showCatButton: UIButton!
    @IBOutlet private var helloLabel: UILabel!
    
    @IBAction func browseTap(){
        let newVC: NewPageViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(identifier: "NewPageViewController")
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    @IBAction func catsTap(_ sender: Any) {
        let catsVC: CatsViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(identifier: "CatsViewController")
        present(catsVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helloLabel.text = "Hello, \(username)!"
    }
}
