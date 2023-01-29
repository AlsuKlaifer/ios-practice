import UIKit

class SignInViewController: UIViewController {
    
    private var username: String = "alsu"
    private var password: String = "1234"

    @IBOutlet private var usernameField: UITextField!
    @IBOutlet private var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInTap(_ sender: Any) {
        if (usernameField.text?.lowercased() == username && passwordField.text == password){
            let mainTBC: MainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
            
            let navVC = mainTBC.viewControllers![0] as! UINavigationController
            let homePageVC = navVC.topViewController as! HomePageViewController
            homePageVC.username = usernameField.text!
            
            let navVC2 = mainTBC.viewControllers![1] as! UINavigationController
            let exitPageVC = navVC2.topViewController as! ExitPageViewController
            exitPageVC.username = usernameField.text!
            
            mainTBC.modalPresentationStyle = .fullScreen
            present(mainTBC, animated: true)
        }
        else{
            let alert = UIAlertController(title: "Error", message: "Wrong username or password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                         NSLog("The \"OK\" alert occured.")
                         }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
