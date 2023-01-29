import UIKit

class ExitPageViewController: UIViewController {
    
    var username = ""
    @IBOutlet private var helloLabel: UILabel!
    
    @IBAction private func signOutTap(){
        let signInPage: SignInViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(identifier: "SignInViewController")
        
        signInPage.modalPresentationStyle = .fullScreen
        present(signInPage, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helloLabel.text = "Hello, \(username)!"
    }
}
