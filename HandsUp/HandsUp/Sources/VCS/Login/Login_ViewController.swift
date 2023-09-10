import UIKit
import FirebaseMessaging

class Login_ViewController: UIViewController {
    @IBOutlet weak var IDTextField_Login: UITextField!
    @IBOutlet weak var PWTextField_Login: UITextField!
    @IBOutlet weak var emailBox_Login: RoundedShadow_UIView!
    @IBOutlet weak var loginErrorMark_Login: UIImageView!
    @IBOutlet weak var showPWButton_Login: UIButton!
    @IBOutlet weak var loginButton_Login: RoundedShadow_UIView!
    @IBOutlet weak var characterImgGroupTopConstraint_Login: NSLayoutConstraint!
    @IBOutlet weak var IDTextFieldTopConstraint_Login: NSLayoutConstraint!
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
    
    
    var isLoginEnable_Login: Bool = false
    var isLoginError_Login: Bool = false
    
    @IBAction func downSwipeGesture(_ sender: Any) {
        if(swipeGesture.direction == .down){
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func setPWSecureTextEntry_Login(_ sender: Any) {
        PWTextField_Login.isSecureTextEntry.toggle()
        if(PWTextField_Login.isSecureTextEntry){
            showPWButton_Login.setImage(UIImage(named:"PWVisibility"), for: .normal)
        }else{
            showPWButton_Login.setImage(UIImage(named:"PWVisibility_off"), for: .normal)
        }
    }
    
    func disableShowPwButton(){
        showPWButton_Login.alpha = 0
    }
    
    func enableShowPwButton(){
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
    
    @IBAction func sign_upButton_Login(_ sender: Any){
        let sign_upData_Login = SignupData()
        let Sign_upSB_Login = UIStoryboard(name: "Sign_up", bundle: nil)
        let sign_upVC_Login = Sign_upSB_Login.instantiateViewController(withIdentifier: "Sign_up") as! Sign_up_ViewController
        sign_upVC_Login.sign_upData_Sign_up = sign_upData_Login
        self.navigationController?.pushViewController(sign_upVC_Login, animated: true)
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
            let status = ServerAPI.login(email: IDTextField_Login.text!, pw: PWTextField_Login.text!)
            switch status{
            case 2000:
                let mainSB_Login = UIStoryboard(name: "Main", bundle: nil)
                let homeVC_Login = mainSB_Login.instantiateViewController(withIdentifier: "Home")
                let result = PostAPI.updateFCMToken(fcmToken: UserDefaults.standard.string(forKey: "fcmToken")!)

                self.navigationController?.pushViewController(homeVC_Login, animated: false)
            case -1:
                ServerError()
            default:
                loginErrorAlert_Login()
            }
        }
    }
    
    func loginErrorAlert_Login(){
        isLoginError_Login = true
        loginErrorMark_Login.alpha = 1
        emailBox_Login.layer.borderWidth = 1
        IDTextField_Login.textColor = UIColor(named: "HandsUpRed")
        emailBox_Login.shake()
        
    }
    
    func disableLoginErrorAlert_Login(){
        isLoginError_Login = false
        loginErrorMark_Login.alpha = 0
        emailBox_Login.layer.borderWidth = 0
        IDTextField_Login.textColor = UIColor(named: "HandsUpDarkGrey")
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
        loginErrorMark_Login.alpha = 0
        emailBox_Login.layer.borderColor = UIColor(named: "HandsUpRed")?.cgColor
        swipeGesture.direction = .down
        detectingInput_Login()
        detectingKeboard_Login()
        self.navigationController?.isNavigationBarHidden = true
        self.hideKeyboard()
        

    }
}
