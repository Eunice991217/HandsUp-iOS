import UIKit

class SocialLogin_ViewController: UIViewController {
    
    @IBOutlet weak var curPageBarX_SocialLogin: NSLayoutConstraint!
    @IBOutlet weak var curPageBarWidth_SocialLogin: NSLayoutConstraint!
    @IBOutlet weak var pageControlView_SocialLogin: RoundedShadow_UIView!
    @IBOutlet weak var titleLable_SocialLogin: UILabel!
    @IBOutlet weak var exclamationMark_SocialLogin: UIImageView!
    @IBOutlet weak var greenCheck_SocialLogin: UIImageView!
    @IBOutlet weak var getVerificationCodeButton_SocialLogin: RoundedShadow_UIButton!
    @IBOutlet weak var verificationCodeBox_SocialLogin: RoundedShadow_UIView!
    @IBOutlet weak var verificationCodeTextField_SocialLogin: UITextField!
    @IBOutlet weak var emailTextField_SocialLogin: UITextField!
    @IBOutlet weak var nextButton_SocialLogin: RoundedShadow_UIButton!
    var sign_upData_SocialLogin: SignupData=SignupData()
    var isVerified_SocialLogin: Bool = false
    
    func titleInit_SocialLogin(){
        titleLable_SocialLogin.text = "학교확인\n도와드릴게요"
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    @IBAction func getVerificationCodeButtonTap_SocialLogin(_ sender: Any) {
        if(emailTextField_SocialLogin.text != ""){
            verificationCodeTextField_SocialLogin.text = ""
            //인증메일 전송
            //verificationCodeTextField_SocialLogin.isEnabled = true
        }
    }
    
    func pageBarInit_SocialLogin(){
        let widthValue_SocialLogin = pageControlView_SocialLogin.frame.size.width / 5
        curPageBarX_SocialLogin.constant = widthValue_SocialLogin * 2
        curPageBarWidth_SocialLogin.constant = widthValue_SocialLogin as CGFloat
    }
    
    func iconInit_SocialLogin(){
        exclamationMark_SocialLogin.alpha = 0
        greenCheck_SocialLogin.alpha = 0
    }
    
    @IBAction func nextButtonTap_SocialLogin(_ sender: Any) {
        if(isVerified_SocialLogin){
            let nicknameVC_SocialLogin = self.storyboard?.instantiateViewController(withIdentifier: "Nickname")
            self.navigationController?.pushViewController(nicknameVC_SocialLogin!, animated: true)
        }
    }
    
    func correctVerificationCode_SocialLogin(){
        greenCheck_SocialLogin.alpha = 1
        exclamationMark_SocialLogin.alpha = 0
        verificationCodeBox_SocialLogin.layer.borderWidth = 1
        verificationCodeBox_SocialLogin.layer.borderColor = UIColor(named: "HandsUpGreen")?.cgColor
        verificationCodeTextField_SocialLogin.textColor = UIColor(named: "HandsUpDarkGrey")
        nextButtonEnable_SocialLogin()
    }
    
    func wrongVerificationCodeError_SocialLogin(){
        greenCheck_SocialLogin.alpha = 0
        exclamationMark_SocialLogin.alpha = 1
        verificationCodeBox_SocialLogin.layer.borderWidth = 1
        verificationCodeBox_SocialLogin.layer.borderColor = UIColor(named: "HandsUpRed")?.cgColor
        verificationCodeTextField_SocialLogin.textColor = UIColor(named: "HandsUpRed")
        nextButtonDisable_SocialLogin()
    }
    
    func nextButtonEnable_SocialLogin(){
        nextButton_SocialLogin.backgroundColor = UIColor(named: "HandsUpOrange")
        isVerified_SocialLogin = true
    }
    func nextButtonDisable_SocialLogin(){
        nextButton_SocialLogin.backgroundColor = UIColor(named: "HandsUpWhiteGrey")
        isVerified_SocialLogin = false
    }
    
    @objc func isEmailInput_SocialLogin(_sender: Any){
        if(emailTextField_SocialLogin.text != ""){
            getVerificationCodeButton_SocialLogin.backgroundColor = UIColor(named: "HandsUpOrange")
        }
        else{
            getVerificationCodeButton_SocialLogin.backgroundColor = UIColor(named: "HandsUpWhiteGrey")
        }
        //verificationCodeTextField_SocialLogin.isEnabled = false
    }
    
    @objc func isCorrectVerificationCode_SocialLogin(_sender: Any){
        if(verificationCodeTextField_SocialLogin.text?.count != 0){
            if(verificationCodeTextField_SocialLogin.text == "12345678"){
                correctVerificationCode_SocialLogin()
            }else{
                wrongVerificationCodeError_SocialLogin()
            }
        }else{
            resetVerificationCodeTextField_SocialLogin()
        }
    }
    
    func resetVerificationCodeTextField_SocialLogin(){
        greenCheck_SocialLogin.alpha = 0
        exclamationMark_SocialLogin.alpha = 0
        verificationCodeBox_SocialLogin.layer.borderWidth = 0
        verificationCodeTextField_SocialLogin.textColor = UIColor(named: "HandsUpDarkGrey")
        
    }
    
    func detectingInput_SocialLogin(){
        emailTextField_SocialLogin.addTarget(self, action: #selector(isEmailInput_SocialLogin(_sender: )), for: .editingChanged)
        verificationCodeTextField_SocialLogin.addTarget(self, action: #selector(isCorrectVerificationCode_SocialLogin(_sender: )), for: .editingChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleInit_SocialLogin()
        pageBarInit_SocialLogin()
        iconInit_SocialLogin()
        detectingInput_SocialLogin()
        self.hideKeyboard()
    }
}
