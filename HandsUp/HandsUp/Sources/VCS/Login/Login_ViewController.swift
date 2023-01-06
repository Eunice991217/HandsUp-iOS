import UIKit

class Login_ViewController: UIViewController {
    @IBOutlet weak var IDTextField_Login: UITextField!
    @IBOutlet weak var PWTextField_Login: UITextField!
    @IBOutlet weak var emailBox_Login: RoundedShadow_UIButton!
    @IBOutlet weak var loginErrorMark_Login: UIImageView!
    @IBOutlet weak var loginButton_Login: RoundedShadow_UIButton!
    var isLoginEnable_Login: Bool = false
    var isLoginError_Login: Bool = false
    
    @IBAction func setPWSecureTextEntry_Login(_ sender: Any) {
        if(PWTextField_Login.isSecureTextEntry){
            PWTextField_Login.isSecureTextEntry = false
        }
        else{
            PWTextField_Login.isSecureTextEntry = true
        }
    }
    
    @IBAction func findPWButton_Login(_ sender: Any) {
        let findPWVC_Login = self.storyboard?.instantiateViewController(withIdentifier: "FindPW")
        self.navigationController?.pushViewController(findPWVC_Login!, animated: true)
    }
    
    @objc func isIDPWInput(_sender: Any?){
        if(isLoginError_Login){
            disableLoginErrorAlert_Login()
        }
        
        if(IDTextField_Login.text != "" && PWTextField_Login.text != ""){
            loginButton_Login.backgroundColor = UIColor(named: "HandsUpOrange")
            self.isLoginEnable_Login = true
            
        }else{
            loginButton_Login.backgroundColor = UIColor(named: "HandsUpWhiteGrey")
            self.isLoginEnable_Login = false
        }
    }
    
    @IBAction func login_Login(_ sender: Any) {
        if(self.isLoginEnable_Login){
            //이메일 로그인 실행
            if(false){
                
            }else{
                loginErrorAlert_Login()
            }
        }
    }
    
    func loginErrorAlert_Login(){
        isLoginError_Login = true
        loginErrorMark_Login.alpha = 1
        emailBox_Login.layer.borderWidth = 1
        IDTextField_Login.textColor = UIColor(named: "HandsUpRed")
    }
    
    func disableLoginErrorAlert_Login(){
        isLoginError_Login = false
        loginErrorMark_Login.alpha = 0
        emailBox_Login.layer.borderWidth = 0
        IDTextField_Login.textColor = UIColor(named: "HandsUpGrey")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginErrorMark_Login.alpha = 0
        emailBox_Login.layer.borderColor = UIColor(named: "HandsUpRed")?.cgColor
        self.IDTextField_Login.addTarget(self, action: #selector(self.isIDPWInput(_sender:)), for: .editingChanged)
        self.PWTextField_Login.addTarget(self, action: #selector(self.isIDPWInput(_sender:)), for: .editingChanged)
        //self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont(name: <#T##String#>, size: 18)
    }
}
