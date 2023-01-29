import UIKit

class NewPageViewController: UIViewController {
    
    var pageNumber = 1
    @IBOutlet private var pageLabel: UILabel!
    
    @IBAction func browseTap(_ sender: Any) {
        let newVC: NewPageViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(identifier: "NewPageViewController")
        newVC.pageNumber = pageNumber + 1
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageLabel.text = "Catalog. Page: \(pageNumber)"
    }
}
