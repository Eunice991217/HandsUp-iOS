import UIKit

class Login_ViewController: UIViewController {
    @IBOutlet weak var IDTextField_Login: UITextField!
    @IBOutlet weak var PWTextField_Login: UITextField!
    @IBOutlet weak var emailBox_Login: RoundedShadow_UIButton!
    @IBOutlet weak var loginErrorMark_Login: UIImageView!
    
    @IBAction func setPWSecureTextEntry_Login(_ sender: Any) {
        if(PWTextField_Login.isSecureTextEntry){
            PWTextField_Login.isSecureTextEntry = false
        }
        else{
            PWTextField_Login.isSecureTextEntry = true
        }
    }
    
    func loginErrorAlert_Login(){
        emailBox_Login.layer.borderWidth = 1
        emailBox_Login.layer.borderColor = UIColor(named: "HandsUpRed")?.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginErrorMark_Login.alpha = 0
        
    }
}
