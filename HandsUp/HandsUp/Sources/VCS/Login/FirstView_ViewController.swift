import UIKit

class FirstView_ViewController: UIViewController {
    
    @IBAction func loginEmailButton_FV(_ sender: Any) {
        self.performSegue(withIdentifier: "showLoginEmail", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
