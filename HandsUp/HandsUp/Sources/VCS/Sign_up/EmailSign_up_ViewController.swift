//
//  EmailSign_up_ViewController.swift
//  HandsUp
//
//  Created by 황재상 on 2023/01/08.
//

import UIKit

class EmailSign_up_ViewController: UIViewController {
    
    @IBOutlet weak var scrollView_EmailSign_up: UIScrollView!
    @IBOutlet weak var curPageBarX_EmailSign_up: NSLayoutConstraint!
    @IBOutlet weak var curPageBarWidth_EmailSign_up: NSLayoutConstraint!
    @IBOutlet weak var pageControlView_EmailSign_up: RoundedShadow_UIView!
    @IBOutlet weak var titleLable_EmailSign_up: UILabel!
    @IBOutlet weak var subTitleLabe_EmailSign_up: UILabel!
    @IBOutlet weak var emailTextField_EmailSign_up: UITextField!
    @IBOutlet weak var getVerificationCodeButton_EmailSign_up: RoundedShadow_UIButton!
    @IBOutlet weak var verificationCodeBox_EmailSign_up: RoundedShadow_UIView!
    @IBOutlet weak var verificationCodeTextField_EmailSign_up: UITextField!
    @IBOutlet weak var greenCheck_EmailSign_up: UIImageView!
    @IBOutlet weak var exclamationMark_EmailSign_up: UIImageView!
    @IBOutlet weak var PWtextField_EmailSign_up: UITextField!
    @IBOutlet weak var showPWButton_EmailSign_up:UIButton!
    @IBOutlet weak var PWConfirmationBox_EmailSign_up: RoundedShadow_UIView!
    @IBOutlet weak var passwordConfirmationTextField_EmailSign_up: UITextField!
    @IBOutlet weak var showPWConfirmationButton_EmailSign_up:UIButton!
    @IBOutlet weak var nextButton_EmailSign_up: RoundedShadow_UIButton!
    @IBOutlet weak var scrollViewBottomConstraints_EmailSign_up: NSLayoutConstraint!
    var sign_upData_EmailSign_up:SignupData = SignupData()
    var isEmailInput_EmailSign_up:Bool = false
    var isEmailVerified_EmailSign_up:Bool = false
    var isCorrectPW_EmailSign_up:Bool = false
    
    @objc func keyboardAppear_EmailSign_up(_ sender: Notification){
        guard let userInfo_EmailSign_up = sender.userInfo,
              let keyboardFrame_EmailSign_up = userInfo_EmailSign_up[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        scrollView_EmailSign_up.contentInset.bottom = keyboardFrame_EmailSign_up.size.height
        
        let firstResponder_EmailSign_up = UIResponder.currentFirstResponder
        if let currentView_EmailSign_up = firstResponder_EmailSign_up as? UITextView {
            scrollView_EmailSign_up.scrollRectToVisible(currentView_EmailSign_up.frame, animated: true)
        }
        scrollViewBottomConstraints_EmailSign_up.constant = 8
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardDisappear_EmailSign_up(_ sender: Any){
        let edgeInset_EmailSign_up = UIEdgeInsets.zero
        scrollView_EmailSign_up.contentInset = edgeInset_EmailSign_up
        scrollView_EmailSign_up.scrollIndicatorInsets = edgeInset_EmailSign_up
        scrollViewBottomConstraints_EmailSign_up.constant = 75
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func isEmailInput_EmailSign_up(_sender: Any){
        if(emailTextField_EmailSign_up.text != ""){
            getVerificationCodeButton_EmailSign_up.backgroundColor = UIColor(named: "HandsUpOrange")
            isEmailInput_EmailSign_up = true
        }
        else{
            getVerificationCodeButton_EmailSign_up.backgroundColor = UIColor(named: "HandsUpWhiteGrey")
            isEmailInput_EmailSign_up = false
        }
        isNextButtonEnable()
        //verificationCodeTextField_EmailSign_up.isEnabled = false
    }
    
    @objc func isCorrectVerificationCode_EmailSign_up(_sender: Any){
        if(verificationCodeTextField_EmailSign_up.text?.count != 0){
            if(verificationCodeTextField_EmailSign_up.text == "12345678"){
                correctVerificationCode_EmailSign_up()
            }else{
                wrongVerificationCodeError_EmailSign_up()
            }
        }else{
            resetVerificationCodeTextField_EmailSign_up()
        }
        isNextButtonEnable()
    }
    
    @objc func isCorrectPWCheck_EmailSign_up(_sender: Any){
        if(passwordConfirmationTextField_EmailSign_up.text == PWtextField_EmailSign_up.text && PWtextField_EmailSign_up.text != ""){
            isCorrectPW_EmailSign_up = true
        }
        else{
            isCorrectPW_EmailSign_up = false
        }
        isNextButtonEnable()
    }
    
    @objc func isPWInput_EmailSign_up(_sender: Any){
        if(PWtextField_EmailSign_up.text == ""){
            showPWButton_EmailSign_up.alpha = 0
        }else{
            showPWButton_EmailSign_up.alpha = 1
        }
    }
    
    @objc func isPWConfirmationInput_EmailSign_up(_sender: Any){
        if(passwordConfirmationTextField_EmailSign_up.text == ""){
            showPWConfirmationButton_EmailSign_up.alpha = 0
        }else{
            showPWConfirmationButton_EmailSign_up.alpha = 1
        }
    }
    
    func resetVerificationCodeTextField_EmailSign_up(){
        greenCheck_EmailSign_up.alpha = 0
        exclamationMark_EmailSign_up.alpha = 0
        verificationCodeBox_EmailSign_up.layer.borderWidth = 0
        verificationCodeTextField_EmailSign_up.textColor = UIColor(named: "HandsUpDarkGrey")
    }
    
    func correctVerificationCode_EmailSign_up(){
        greenCheck_EmailSign_up.alpha = 1
        exclamationMark_EmailSign_up.alpha = 0
        verificationCodeBox_EmailSign_up.layer.borderWidth = 1
        verificationCodeBox_EmailSign_up.layer.borderColor = UIColor(named: "HandsUpGreen")?.cgColor
        verificationCodeTextField_EmailSign_up.textColor = UIColor(named: "HandsUpDarkGrey")
        isEmailVerified_EmailSign_up = true
    }
    
    func wrongVerificationCodeError_EmailSign_up(){
        greenCheck_EmailSign_up.alpha = 0
        exclamationMark_EmailSign_up.alpha = 1
        verificationCodeBox_EmailSign_up.layer.borderWidth = 1
        verificationCodeBox_EmailSign_up.layer.borderColor = UIColor(named: "HandsUpRed")?.cgColor
        verificationCodeTextField_EmailSign_up.textColor = UIColor(named: "HandsUpRed")
        isEmailVerified_EmailSign_up = false
    }
    
    func isNextButtonEnable(){
        if(isCorrectPW_EmailSign_up && isEmailVerified_EmailSign_up && isEmailInput_EmailSign_up){
            nextButton_EmailSign_up.backgroundColor = UIColor(named: "HandsUpOrange")
        }else{
            nextButton_EmailSign_up.backgroundColor = UIColor(named: "HandsUpWhiteGrey")
        }
    }
    
    func titleInit_EmailSign_up(){
        titleLable_EmailSign_up.text = "학교확인\n도와드릴게요"
        subTitleLabe_EmailSign_up.text = "학교이메일을 적고 비밀번호를\n만들어주세요."
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func pageBarInit_EmailSign_up(){
        let widthValue_EmailSign_up = pageControlView_EmailSign_up.frame.size.width / 5
        curPageBarX_EmailSign_up.constant = widthValue_EmailSign_up * 2
        curPageBarWidth_EmailSign_up.constant = widthValue_EmailSign_up as CGFloat
    }
    
    func iconsInit_EmailSign_up(){
        greenCheck_EmailSign_up.alpha = 0
        exclamationMark_EmailSign_up.alpha = 0
        showPWButton_EmailSign_up.alpha = 0
        showPWConfirmationButton_EmailSign_up.alpha = 0
    }
    
    func detectingInput_EmailSign_up(){
        emailTextField_EmailSign_up.addTarget(self, action: #selector(isEmailInput_EmailSign_up(_sender: )), for: .editingChanged)
        verificationCodeTextField_EmailSign_up.addTarget(self, action: #selector(isCorrectVerificationCode_EmailSign_up(_sender: )), for: .editingChanged)
        PWtextField_EmailSign_up.addTarget(self, action: #selector(isCorrectPWCheck_EmailSign_up(_sender: )), for: .editingChanged)
        PWtextField_EmailSign_up.addTarget(self, action: #selector(isPWInput_EmailSign_up(_sender: )), for: .editingChanged)
        passwordConfirmationTextField_EmailSign_up.addTarget(self, action: #selector(isCorrectPWCheck_EmailSign_up(_sender: )), for: .editingChanged)
        passwordConfirmationTextField_EmailSign_up.addTarget(self, action: #selector(isPWConfirmationInput_EmailSign_up(_sender: )), for: .editingChanged)
    }
    
    func detectingKeboard_EmailSign_up(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear_EmailSign_up(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear_EmailSign_up(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func getVerificationCodeButtonTap_EmailSign_up(_ sender: Any) {
        if(emailTextField_EmailSign_up.text != ""){
            isEmailVerified_EmailSign_up = false
            verificationCodeTextField_EmailSign_up.text = ""
            resetVerificationCodeTextField_EmailSign_up()
            //인증메일 전송
            //verificationCodeTextField_EmailSign_up.isEnabled = true
        }
    }
    
    @IBAction func setPWSecureTextEntry_EmailSign_up(_ sender: Any) {
        PWtextField_EmailSign_up.isSecureTextEntry.toggle()
    }
    
    @IBAction func setPWConfirmationSecureTextEntry_EmailSign_up(_ sender: Any) {
        passwordConfirmationTextField_EmailSign_up.isSecureTextEntry.toggle()
    }
    
    @IBAction func nextButtonTap_EmailSign_up(_ sender: Any) {
        if(nextButton_EmailSign_up.backgroundColor == UIColor(named: "HandsUpOrange")){
            let nicknameVC_EmailSign_up = self.storyboard?.instantiateViewController(withIdentifier: "Nickname")
            self.navigationController?.pushViewController(nicknameVC_EmailSign_up!, animated: true)
            verificationCodeTextField_EmailSign_up.addTarget(self, action: #selector(isCorrectVerificationCode_EmailSign_up(_sender: )), for: .editingChanged)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleInit_EmailSign_up()
        pageBarInit_EmailSign_up()
        iconsInit_EmailSign_up()
        detectingInput_EmailSign_up()
        detectingKeboard_EmailSign_up()
        self.hideKeyboard()
    }
}

extension UIResponder {
    private static weak var _currentFirstResponder: UIResponder?
    
    static var currentFirstResponder: UIResponder? {
        _currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(UIResponder.findFirstResponder(_:)), to: nil, from: nil, for: nil)
        
        return _currentFirstResponder
    }
    
    @objc func findFirstResponder(_ sender: Any) {
        UIResponder._currentFirstResponder = self
    }
}
