import UIKit

class Login_ViewController: UIViewController {
    @IBOutlet weak var IDTextField_Login: UITextField!
    @IBOutlet weak var PWTextField_Login: UITextField!
    @IBOutlet weak var emailBox_Login: RoundedShadow_UIButton!
    @IBOutlet weak var loginErrorMark_Login: UIImageView!
    @IBOutlet weak var showPWButton_Login: UIButton!
    @IBOutlet weak var loginButton_Login: RoundedShadow_UIButton!
    @IBOutlet weak var characterImgGroupTopConstraint_Login: NSLayoutConstraint!
    @IBOutlet weak var IDTextFieldTopConstraint_Login: NSLayoutConstraint!
    var isLoginEnable_Login: Bool = false
    var isLoginError_Login: Bool = false
    
    @IBAction func setPWSecureTextEntry_Login(_ sender: Any) {
        PWTextField_Login.isSecureTextEntry.toggle()
    }
    
    func disableShowPwButton(){
        showPWButton_Login.isEnabled = false
        showPWButton_Login.alpha = 0
        PWTextField_Login.textContentType = .password
    }
    
    func enableShowPwButton(){
        showPWButton_Login.isEnabled = true
        showPWButton_Login.alpha = 1
        
    }
    
    @objc func keyboardAppear_Login(_ sender : Any){
        characterImgGroupTopConstraint_Login.constant = 76
        IDTextFieldTopConstraint_Login.constant=48
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardDisappear_Login(_ sender : Any){
        characterImgGroupTopConstraint_Login.constant = 100
        IDTextFieldTopConstraint_Login.constant = 69;
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
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
    
    @objc func isPWInput(_sender: Any?){
        if(PWTextField_Login.text == ""){
            disableShowPwButton()
        }else{
            enableShowPwButton()
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
    
    func detectingInput_Login(){
        self.IDTextField_Login.addTarget(self, action: #selector(self.isIDPWInput(_sender:)), for: .editingChanged)
        self.PWTextField_Login.addTarget(self, action: #selector(self.isIDPWInput(_sender:)), for: .editingChanged)
        self.PWTextField_Login.addTarget(self, action: #selector(self.isPWInput(_sender:)), for: .editingChanged)
    }
    
    func detectingKeboard_Login(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear_Login(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear_Login(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableShowPwButton()
        IDTextField_Login.keyboardType = .emailAddress
        PWTextField_Login.keyboardType = .asciiCapable
        loginErrorMark_Login.alpha = 0
        emailBox_Login.layer.borderColor = UIColor(named: "HandsUpRed")?.cgColor
        detectingInput_Login()
        detectingKeboard_Login()
    }
}
