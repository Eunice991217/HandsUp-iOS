//
//  Sign_up_ViewController.swift
//  HandsUp
//
//  Created by 황재상 on 2023/01/12.
//

import UIKit
import SafariServices

class Sign_up_ViewController: UIViewController, sendCharacterDataDelegate {
    //Page
    @IBOutlet weak var BackButton_Sign_up: UIButton!
    @IBOutlet weak var pageControllBar_Sign_up: RoundedShadow_UIView!
    @IBOutlet weak var curBarWidth_Sign_up: NSLayoutConstraint!
    @IBOutlet weak var nextButton_Sign_up: RoundedShadow_UIButton!
    @IBOutlet weak var page1_Sign_up: UIView!
    @IBOutlet weak var page2Width_Sign_up: NSLayoutConstraint!
    @IBOutlet weak var page2Leading_Sign_up: NSLayoutConstraint!
    @IBOutlet weak var page3Width_Sign_up: NSLayoutConstraint!
    @IBOutlet weak var page3Leading_Sign_up: NSLayoutConstraint!
    @IBOutlet weak var page4Width_Sign_up: NSLayoutConstraint!
    @IBOutlet weak var page4Leading_Sign_up: NSLayoutConstraint!
    @IBOutlet weak var page5Width_Sign_up: NSLayoutConstraint!
    @IBOutlet weak var page5Leading_Sign_up: NSLayoutConstraint!
    
    //Page1
    @IBOutlet weak var titlePG1_Sign_up: UILabel!
    @IBOutlet weak var subTitlePG1_Sign_up: UILabel!
    @IBOutlet weak var checkBoxButton1_Sign_up: RoundedShadow_UIButton!
    @IBOutlet weak var checkBoxButton2_Sign_up: RoundedShadow_UIButton!
    @IBOutlet weak var checkBoxButton3_Sign_up: RoundedShadow_UIButton!
    @IBOutlet weak var checkBoxButton4_Sign_up: RoundedShadow_UIButton!
    var agreement_Sign_up =  [Bool](repeating: false, count: 4)
    
    //Page2
    @IBOutlet weak var titlePG2_Sign_up: UILabel!
    @IBOutlet weak var subTitlePG2_Sign_up: UILabel!
    @IBOutlet weak var schoolPickerView_Sign_up: UIPickerView!
    var schoolList_Sign_up: [String] = ["가천대학교", "건국대학교", "동국대학교", "세종대학교", "숭실대학교" ]
    //Page3
    @IBOutlet weak var titlePG3_Sign_up: UILabel!
    @IBOutlet weak var subTitlePG3_Sign_up: UILabel!
    @IBOutlet weak var scrollView_Sign_up: UIScrollView!
    @IBOutlet weak var emailTextField_Sign_up: UITextField!
    @IBOutlet weak var getVerificationCodeButton_Sign_up: RoundedShadow_UIButton!
    @IBOutlet weak var verificationCodeBox_Sign_up: RoundedShadow_UIView!
    @IBOutlet weak var verificationCodeTextField_Sign_up: UITextField!
    @IBOutlet weak var greenCheck_Sign_up: UIImageView!
    @IBOutlet weak var exclamationMark_Sign_up: UIImageView!
    @IBOutlet weak var PWtextField_Sign_up: UITextField!
    @IBOutlet weak var showPWButton_Sign_up:UIButton!
    @IBOutlet weak var passwordConfirmationTextField_Sign_up: UITextField!
    @IBOutlet weak var showPWConfirmationButton_Sign_up:UIButton!
    var isVerified_Sign_up: Bool = true
    var isCorrectPW_Sign_up: Bool = false
    
    //Page4
    @IBOutlet weak var titlePG4_Sign_up: UILabel!
    @IBOutlet weak var subTitlePG4_Sign_up: UILabel!
    @IBOutlet weak var nicknameTextField_Sign_up: UITextField!
    
    //Page5
    @IBOutlet weak var titlePG5_Sign_up: UILabel!
    @IBOutlet weak var subTitlePG5_Sign_up: UILabel!
    @IBOutlet weak var character_Sign_up: Character_UIView!
    @IBOutlet weak var characterButton_Sign_up: UIButton!
    
    var sign_upData_Sign_up : SignupData = SignupData()
    let titleArray_Sign_up: [String] = ["대학생 여러분 \n환영합니다:)", "다니시는 대학교\n선택해주세요", "학교확인\n도와드릴게요", "닉네임을\n만들어보세요", "자신의 프로필\n캐릭터를 만들어봐요!"]
    var subTitleArray_Sign_up: [String] = ["원활한 서비스 이용을 위해 동의해주세요", "해당 대학교학생들만 사용가능해요", "학교이메일을 적고 비밀번호를\n만들어주세요.", "닉네임은 7일후 변경가능하니 신중히\n선택해주세요:)", "캐릭터 클릭해 만들고\n자신만의 개성을 뽐내봐요!"]
    var curPageCGFloat_Sign_up: CGFloat = 1
    var curPageInt_Sign_up: Int = 1
    var isNextButtonActive_Sign_up: Bool = false
    var pageWidth_Sign_up: CGFloat = 1

    //Page func
    func pageUpdate_Sign_up(){
        if(curPageInt_Sign_up < 5){
            curBarWidth_Sign_up.constant = pageControllBar_Sign_up.frame.width * curPageCGFloat_Sign_up / 5
        }else{
            curBarWidth_Sign_up.constant = pageControllBar_Sign_up.frame.width
        }
        switch curPageInt_Sign_up{
        case 1:
            page2Leading_Sign_up.constant = pageWidth_Sign_up
            isNextButtonActive_Sign_up = sign_upData_Sign_up.policyAgreement
        case 2:
            page3Leading_Sign_up.constant = pageWidth_Sign_up
            page2Leading_Sign_up.constant = 0
            isNextButtonActive_Sign_up = true
        case 3:
            page4Leading_Sign_up.constant = pageWidth_Sign_up
            page3Leading_Sign_up.constant = 0
            isNextButtonActive_Sign_up = (isVerified_Sign_up && isCorrectPW_Sign_up)
            addKeyboardObserver_Sign_up()
        case 4:
            page5Leading_Sign_up.constant = pageWidth_Sign_up
            page4Leading_Sign_up.constant = 0
            isNextButtonActive_Sign_up = nicknameValidation_Sign_up(text: sign_upData_Sign_up.nickname)
            removeKeyboardObserver_Sign_up()
        case 5:
            page5Leading_Sign_up.constant = 0
            isNextButtonActive_Sign_up = true
        default:
            print("error")
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func titleUpdate_Sign_up(){
        if(curPageInt_Sign_up == 5){
            nextButton_Sign_up.setTitle("핸즈업 들어가기", for: .normal)
        }
        else{
            nextButton_Sign_up.setTitle("다음", for: .normal)
        }
        nextButton_Sign_up.setTitleColor(UIColor(named: "HandsUpRealWhite"), for: .normal)
    }
    
    
    func pageInit_Sign_up(){
        curBarWidth_Sign_up.constant = pageControllBar_Sign_up.frame.width * curPageCGFloat_Sign_up / 5
        titlePG1_Sign_up.text = titleArray_Sign_up[0]
        subTitlePG1_Sign_up.text = subTitleArray_Sign_up[0]
        titlePG2_Sign_up.text = titleArray_Sign_up[1]
        subTitlePG2_Sign_up.text = subTitleArray_Sign_up[1]
        titlePG3_Sign_up.text = titleArray_Sign_up[2]
        subTitlePG3_Sign_up.text = subTitleArray_Sign_up[2]
        titlePG4_Sign_up.text = titleArray_Sign_up[3]
        subTitlePG4_Sign_up.text = subTitleArray_Sign_up[3]
        titlePG5_Sign_up.text = titleArray_Sign_up[4]
        subTitlePG5_Sign_up.text = subTitleArray_Sign_up[4]
        
        pageWidth_Sign_up = UIScreen.main.bounds.size.width
        page2Width_Sign_up.constant = pageWidth_Sign_up
        page2Leading_Sign_up.constant = pageWidth_Sign_up
        page3Width_Sign_up.constant = pageWidth_Sign_up
        page3Leading_Sign_up.constant = pageWidth_Sign_up
        page4Width_Sign_up.constant = pageWidth_Sign_up
        page4Leading_Sign_up.constant = pageWidth_Sign_up
        page5Width_Sign_up.constant = pageWidth_Sign_up
        page5Leading_Sign_up.constant = pageWidth_Sign_up
        
        page1Init_Sign_up()
        page2Init_Sign_up()
        page3Init_Sign_up()
        page4Init_Sign_up()
        page5Init_Sign_up()
    }
    
    func changeNextButtonState_Sign_up(){
        if(isNextButtonActive_Sign_up){
            nextButton_Sign_up.backgroundColor = UIColor(named: "HandsUpOrange")
        }
        else{
            nextButton_Sign_up.backgroundColor = UIColor(named: "HandsUpWhiteGrey")
        }
    }
    
    @IBAction func nextButtonTap_Sign_up(_ sender: Any){
        if(isNextButtonActive_Sign_up){
            if(curPageInt_Sign_up == 4){
                sign_upData_Sign_up.nickname = nicknameTextField_Sign_up.text!
            }
            
            if(curPageInt_Sign_up < 5){
                curPageInt_Sign_up += 1
                curPageCGFloat_Sign_up += 1
                pageUpdate_Sign_up()
                changeNextButtonState_Sign_up()
                titleUpdate_Sign_up()
            }
        }
    }
    
    @IBAction func backButtonTap_Sign_up(_ sender: Any) {
        if(curPageInt_Sign_up > 1){
            curPageInt_Sign_up -= 1
            curPageCGFloat_Sign_up -= 1
            pageUpdate_Sign_up()
            changeNextButtonState_Sign_up()
            titleUpdate_Sign_up()
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.hideKeyboard()
        pageInit_Sign_up()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        character_Sign_up.setCharacter(componentArray: sign_upData_Sign_up.characterComponent)
    }
    
    func sendCharacterData(data: SignupData) {
        for i in 0...6{
            sign_upData_Sign_up.characterComponent[i] = data.characterComponent[i]
        }
    }
    
    //Page 1
    func page1Init_Sign_up(){
        checkBoxButton1_Sign_up.setImage(nil, for: .normal)
        checkBoxButton2_Sign_up.setImage(nil, for: .normal)
        checkBoxButton3_Sign_up.setImage(nil, for: .normal)
        checkBoxButton4_Sign_up.setImage(nil, for: .normal)
    }
    
    func checkAgreement_Sign_up()->Bool{
        for check_Sign_up in agreement_Sign_up{
            if(!check_Sign_up){
                sign_upData_Sign_up.policyAgreement = false
                return false
            }
        }
        sign_upData_Sign_up.policyAgreement = true
        return true
    }
    
    @IBAction func checkBox1Tap_Sign_up(_ sender: Any){
        if(agreement_Sign_up[0]){
            checkBoxButton1_Sign_up.setImage(nil, for: .normal)
            agreement_Sign_up[0] = false
        }else{
            checkBoxButton1_Sign_up.setImage(UIImage(named: "OrangeCheck"), for: .normal)
            agreement_Sign_up[0] = true
        }
        isNextButtonActive_Sign_up = checkAgreement_Sign_up()
        changeNextButtonState_Sign_up()
    }
    
    @IBAction func checkBox2Tap_Sign_up(_ sender: Any){
        if(agreement_Sign_up[1]){
            checkBoxButton2_Sign_up.setImage(nil, for: .normal)
            agreement_Sign_up[1] = false
        }else{
            checkBoxButton2_Sign_up.setImage(UIImage(named: "OrangeCheck"), for: .normal)
            agreement_Sign_up[1] = true
        }
        isNextButtonActive_Sign_up = checkAgreement_Sign_up()
        changeNextButtonState_Sign_up()
    }
    
    @IBAction func checkBox3Tap_Sign_up(_ sender: Any){
        if(agreement_Sign_up[2]){
            checkBoxButton3_Sign_up.setImage(nil, for: .normal)
            agreement_Sign_up[2] = false
        }else{
            checkBoxButton3_Sign_up.setImage(UIImage(named: "OrangeCheck"), for: .normal)
            agreement_Sign_up[2] = true
        }
        isNextButtonActive_Sign_up = checkAgreement_Sign_up()
        changeNextButtonState_Sign_up()
    }
    
    @IBAction func checkBox4Tap_Sign_up(_ sender: Any){
        if(agreement_Sign_up[3]){
            checkBoxButton4_Sign_up.setImage(nil, for: .normal)
            agreement_Sign_up[3] = false
        }else{
            checkBoxButton4_Sign_up.setImage(UIImage(named: "OrangeCheck"), for: .normal)
            agreement_Sign_up[3] = true
        }
        isNextButtonActive_Sign_up = checkAgreement_Sign_up()
        changeNextButtonState_Sign_up()
    }
    
    @IBAction func TermsButton_Sign_up(_ sender: Any) {
        let termUrl_Sign_up = NSURL(string: "https://miniahiru.notion.site/55bb2cb2fd8b4f3db75775c7065977a2")
        let termSafariView_Sign_up: SFSafariViewController = SFSafariViewController(url: termUrl_Sign_up! as URL)
        self.present(termSafariView_Sign_up, animated: true, completion: nil)
    }
    
    //Page 2
    func page2Init_Sign_up(){
        sign_upData_Sign_up.school = schoolList_Sign_up[0]
        schoolPickerView_Sign_up.delegate = self
        schoolPickerView_Sign_up.dataSource = self
    }
    
    override func viewWillLayoutSubviews() {
        schoolPickerView_Sign_up.subviews[1].backgroundColor = .clear
    }
    
    //Page 3
    @IBAction func setPWSecureTextEntry_EmailSign_up(_ sender: Any) {
        PWtextField_Sign_up.isSecureTextEntry.toggle()
        if(PWtextField_Sign_up.isSecureTextEntry){
            showPWButton_Sign_up.setImage(UIImage(named:"PWVisibility"), for: .normal)
        }else{
            showPWButton_Sign_up.setImage(UIImage(named:"PWVisibility_off"), for: .normal)
        }
    }
    
    @IBAction func setPWConfirmationSecureTextEntry_EmailSign_up(_ sender: Any) {
        passwordConfirmationTextField_Sign_up.isSecureTextEntry.toggle()
        if(passwordConfirmationTextField_Sign_up.isSecureTextEntry){
            showPWConfirmationButton_Sign_up.setImage(UIImage(named:"PWVisibility"), for: .normal)
        }else{
            showPWConfirmationButton_Sign_up.setImage(UIImage(named:"PWVisibility_off"), for: .normal)
        }
    }
    
    func page3Init_Sign_up(){
        //emailTextField_Sign_up.addTarget(self, action: #selector(isEmailInput_Sign_up(_sender: )), for: .editingChanged)
        //verificationCodeTextField_Sign_up.addTarget(self, action: #selector(isCorrectVerificationCode_Sign_up(_sender: )), for: .editingChanged)
        PWtextField_Sign_up.addTarget(self, action: #selector(isCorrectPWCheck_Sign_up(_sender: )), for: .editingChanged)
        PWtextField_Sign_up.addTarget(self, action: #selector(isPWInput_Sign_up(_sender: )), for: .editingChanged)
        passwordConfirmationTextField_Sign_up.addTarget(self, action: #selector(isCorrectPWCheck_Sign_up(_sender: )), for: .editingChanged)
        passwordConfirmationTextField_Sign_up.addTarget(self, action: #selector(isPWConfirmationInput_Sign_up(_sender: )), for: .editingChanged)
        
        greenCheck_Sign_up.alpha = 0
        exclamationMark_Sign_up.alpha = 0
        showPWButton_Sign_up.alpha = 0
        showPWConfirmationButton_Sign_up.alpha = 0
        
    }
    
    func addKeyboardObserver_Sign_up(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear_Sign_up(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear_Sign_up(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardObserver_Sign_up(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardAppear_Sign_up(_ sender: Notification){
        guard let userInfo_Sign_up = sender.userInfo,
              let keyboardFrame_Sign_up = userInfo_Sign_up[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        scrollView_Sign_up.contentInset.bottom = keyboardFrame_Sign_up.size.height       
        let firstResponder_Sign_up = UIResponder.currentFirstResponder
        if let currentView_Sign_up = firstResponder_Sign_up as? UITextView {
            scrollView_Sign_up.scrollRectToVisible(currentView_Sign_up.frame, animated: true)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardDisappear_Sign_up(_ sender: Any){
        let edgeInset_Sign_up = UIEdgeInsets.zero
        scrollView_Sign_up.contentInset = edgeInset_Sign_up
        scrollView_Sign_up.scrollIndicatorInsets = edgeInset_Sign_up
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func isCorrectPWCheck_Sign_up(_sender: Any){
        let PWArray_Sign_up = Array(PWtextField_Sign_up.text ?? "")
        var regexPW_Sign_up: Bool = true
        if(8 <= PWArray_Sign_up.count && PWArray_Sign_up.count <= 10){
            let pattern_Sign_up = "^[a-zA-Z0-9]$"
            if let regex_Sign_up = try? NSRegularExpression(pattern: pattern_Sign_up, options: .caseInsensitive) {
                var index_Sign_up = 0
                while index_Sign_up < PWArray_Sign_up.count {
                    let results_Sign_up = regex_Sign_up.matches(in: String(PWArray_Sign_up[index_Sign_up]), options: [], range: NSRange(location: 0, length: 1))
                    if results_Sign_up.count == 0 {
                        regexPW_Sign_up = false
                    } else {
                        index_Sign_up += 1
                    }
                }
            }
        }else{
            regexPW_Sign_up = false
        }
        
        if(regexPW_Sign_up){
            if(passwordConfirmationTextField_Sign_up.text == PWtextField_Sign_up.text && PWtextField_Sign_up.text != ""){
                sign_upData_Sign_up.PW = PWtextField_Sign_up.text!
                isCorrectPW_Sign_up = true
            }
        }
        else{
            sign_upData_Sign_up.PW = ""
            isCorrectPW_Sign_up = false
        }
        
        isNextButtonActive_Sign_up = isVerified_Sign_up && isCorrectPW_Sign_up
        changeNextButtonState_Sign_up()
    }
    
    
    @objc func isPWInput_Sign_up(_sender: Any){
        if(PWtextField_Sign_up.text == ""){
            showPWButton_Sign_up.alpha = 0
        }else{
            showPWButton_Sign_up.alpha = 1
        }
    }
    
    @objc func isPWConfirmationInput_Sign_up(_sender: Any){
        if(passwordConfirmationTextField_Sign_up.text == ""){
            showPWConfirmationButton_Sign_up.alpha = 0
        }else{
            showPWConfirmationButton_Sign_up.alpha = 1
        }
    }
    
    //Page 4
    func page4Init_Sign_up(){
        nicknameTextField_Sign_up.addTarget(self, action: #selector(nicknameInput_Sign_up(_sender: )), for: .editingChanged)
    }
    
    func nicknameValidation_Sign_up(text: String) -> Bool{
        let nickNameArray_Sign_up = Array(text)
        if(nickNameArray_Sign_up.count < 2 || 5 < nickNameArray_Sign_up.count){
            return false
        }
        let pattern_Sign_up = "^[가-힣]$"
        if let regex_Sign_up = try? NSRegularExpression(pattern: pattern_Sign_up, options: .caseInsensitive) {
                var index_Sign_up = 0
                while index_Sign_up < nickNameArray_Sign_up.count {
                    let results_Sign_up = regex_Sign_up.matches(in: String(nickNameArray_Sign_up[index_Sign_up]), options: [], range: NSRange(location: 0, length: 1))
                    if results_Sign_up.count == 0 {
                        return false
                    } else {
                        index_Sign_up += 1
                    }
                }
            }
        return true
    }
    
    @objc func nicknameInput_Sign_up(_sender: Any){
        let nickname_Sign_up:String = nicknameTextField_Sign_up.text ?? ""
        if(nicknameValidation_Sign_up(text: nickname_Sign_up)){
            isNextButtonActive_Sign_up = true
        }else{
            isNextButtonActive_Sign_up = false
        }
        changeNextButtonState_Sign_up()
    }
    
    //Page 5
    func page5Init_Sign_up(){
        character_Sign_up.setAll(componentArray: sign_upData_Sign_up.characterComponent)
        character_Sign_up.setCharacter()
    }
    
    @IBAction func characterHighlight_Sign_up(_ sender: Any){
        character_Sign_up.highlightToggle()
    }
    
    @IBAction func characterChange_Sign_up(_ sender: Any){
        let characterEditVC_Sign_up = self.storyboard?.instantiateViewController(withIdentifier: "CharacterEdit") as! CharacterEdit_ViewController
        var componentIndex_Sign_up = 0
        sign_upData_Sign_up.characterComponent.forEach{
            characterEditVC_Sign_up.sign_upData_CharacterEdit.characterComponent[componentIndex_Sign_up] = $0
            componentIndex_Sign_up += 1
        }
        characterEditVC_Sign_up.modalPresentationStyle = .fullScreen
        characterEditVC_Sign_up.delegate = self
        self.present(characterEditVC_Sign_up,animated:true)
    }
    
}

extension Sign_up_ViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let selectView_Sign_up = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 52))
        let schoolLabel_Sign_up = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 52))
        schoolLabel_Sign_up.text = schoolList_Sign_up[row]
        schoolLabel_Sign_up.textAlignment = .center
        schoolLabel_Sign_up.font = UIFont(name: "Roboto-Bold", size: 16)
        schoolLabel_Sign_up.textColor = UIColor(named: "HandUpMainText")
        
        selectView_Sign_up.addSubview(schoolLabel_Sign_up)
        return selectView_Sign_up
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return schoolList_Sign_up.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sign_upData_Sign_up.school = schoolList_Sign_up[row]
    }
}
