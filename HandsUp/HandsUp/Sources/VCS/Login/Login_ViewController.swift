import UIKit

class Login_ViewController: UIViewController {
    @IBOutlet weak var IDTextField_Login: UITextField!
    @IBOutlet weak var PWTextField_Login: UITextField!
    @IBOutlet weak var emailBox_Login: RoundedShadow_UIButton!
    @IBOutlet weak var loginErrorMark_Login: UIImageView!
    @IBOutlet weak var loginButton_Login: RoundedShadow_UIButton!
    
    @IBAction func setPWSecureTextEntry_Login(_ sender: Any) {
        if(PWTextField_Login.isSecureTextEntry){
            PWTextField_Login.isSecureTextEntry = false
        }
        else{
            PWTextField_Login.isSecureTextEntry = true
        }
    }
    
    @objc func isIDPWInput(_sender: Any?){
        if(IDTextField_Login.text != "" && PWTextField_Login.text != ""){
            loginButton_Login.backgroundColor = UIColor(named: "HandsUpOrange")
        }else{
            loginButton_Login.backgroundColor = UIColor(named: "HandsUpWhiteGrey")
        }
    }
    
    func loginErrorAlert_Login(){
        loginErrorMark_Login.alpha = 1
        emailBox_Login.layer.borderWidth = 1
        emailBox_Login.layer.borderColor = UIColor(named: "HandsUpRed")?.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginErrorMark_Login.alpha = 0
        self.IDTextField_Login.addTarget(self, action: #selector(self.isIDPWInput(_sender:)), for: .editingChanged)
        self.PWTextField_Login.addTarget(self, action: #selector(self.isIDPWInput(_sender:)), for: .editingChanged)
    }
}
