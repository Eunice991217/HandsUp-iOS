//
//  Nickname_ViewController.swift
//  HandsUp
//
//  Created by 황재상 on 2023/01/08.
//

import UIKit

class Nickname_ViewController: UIViewController {

    @IBOutlet weak var curPageBarX_Nickname: NSLayoutConstraint!
    @IBOutlet weak var curPageBarWidth_Nickname: NSLayoutConstraint!
    @IBOutlet weak var pageControlView_Nickname: RoundedShadow_UIView!
    @IBOutlet weak var titleLable_Nickname: UILabel!
    @IBOutlet weak var subTitleLabe_Nickname: UILabel!
    @IBOutlet weak var nicknameTextField_Nickname: UITextField!
    @IBOutlet weak var nextButton_Nickname: RoundedShadow_UIButton!
    var sign_upData_Nickname: SignupData=SignupData()
    var nextButtonEnable_Nickname : Bool = false
    
    func titleInit_Nickname(){
        titleLable_Nickname.text = "닉네임을\n만들어보세요"
        subTitleLabe_Nickname.text = "닉네임은 7일후 변경가능하니 신중히\n선택해주세요:)"
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func pageBarInit_Nickname(){
        let widthValue_Nickname = pageControlView_Nickname.frame.size.width * 4 / 5
        curPageBarX_Nickname.constant = 0
        curPageBarWidth_Nickname.constant = widthValue_Nickname as CGFloat
    }
    
    @IBAction func nextButtonTap_Nickname(_ sender: Any) {
        if(nextButtonEnable_Nickname){
            let profileVC_Nickname = self.storyboard?.instantiateViewController(withIdentifier: "Profile")
            self.navigationController?.pushViewController(profileVC_Nickname!, animated: false)
        }
    }
    
    @objc func isNicknameInput_Nickname(_sender: Any){
        let nicknameLengh_Nickname = nicknameTextField_Nickname.text!.count
        if(2 <= nicknameLengh_Nickname && nicknameLengh_Nickname <= 5 ){
            if(!nextButtonEnable_Nickname){
                nextButtonEnable_Nickname = true
                nextButton_Nickname.backgroundColor = UIColor(named: "HandsUpOrange")
            }        }else{

                if(nextButtonEnable_Nickname){
                nextButtonEnable_Nickname = false
                nextButton_Nickname.backgroundColor = UIColor(named: "HandsUpWhiteGrey")
            }
        }
    }
    
    func detectingInput_SocialLogin(){
        nicknameTextField_Nickname.addTarget(self, action: #selector(isNicknameInput_Nickname(_sender: )), for: .editingChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleInit_Nickname()
        pageBarInit_Nickname()
        detectingInput_SocialLogin()
        self.hideKeyboard()
    }
    
}
