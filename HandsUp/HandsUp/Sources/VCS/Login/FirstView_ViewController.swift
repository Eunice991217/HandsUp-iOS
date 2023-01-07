import UIKit

class FirstView_ViewController: UIViewController {
    
    @IBAction func loginGoogleButton_FV(_ sender: Any) {
    }
    
    @IBAction func loginAppleButton_FV(_ sender: Any) {
        
    }
    @IBAction func loginKakaoButton_FV(_ sender: Any) {
        
    }
    
    @IBAction func loginEmailButton_FV(_ sender: Any) {
        self.performSegue(withIdentifier: "showLoginEmail", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
