//
//  Sign_up_ViewController.swift
//  HandsUp
//
//  Created by 황재상 on 2023/01/12.
//

import UIKit

class Sign_up_ViewController: UIViewController {
    
    @IBOutlet weak var BackButton_Sign_up: UIButton!
    @IBOutlet weak var pageControllBar_Sign_up: RoundedShadow_UIView!
    @IBOutlet weak var curBarWidth_Sign_up: NSLayoutConstraint!
    @IBOutlet weak var title_Sign_up: UILabel!
    @IBOutlet weak var subTitle_Sign_up: UILabel!
    
    @IBOutlet weak var nextButton_Sign_up: RoundedShadow_UIButton!
    var sign_upData_Sign_up : SignupData = SignupData()
    let titleArray_Sign_up: [String] = ["대학생 여러분 \n환영합니다:)", "다니시는 대학교\n선택해주세요", "학교확인\n도와드릴게요", "닉네임을\n만들어보세요", "자신의 프로필\n캐릭터를 만들어봐요!"]
    var subTitleArray_Sign_up: [String] = ["원활한 서비스 이용을 위해 동의해주세요", "다니시는 대학교\n선택해주세요", "", "닉네임은 7일후 변경가능하니 신중히\n선택해주세요:)", "캐릭터 클릭해 만들고\n자신만의 개성을 뽐내봐요!"]
    var curPageCGFloat_Sign_up: CGFloat = 1
    var curPageInt_Sign_up: Int = 1
    
    func pageUpdate_Sign_up(){
        if(curPageInt_Sign_up < 5){
            curBarWidth_Sign_up.constant = pageControllBar_Sign_up.frame.width * curPageCGFloat_Sign_up / 5
        }else{
            curBarWidth_Sign_up.constant = pageControllBar_Sign_up.frame.width
        }
        //title_Sign_up.text = titleArray_Sign_up[curPageInt_Sign_up - 1]
        //subTitle_Sign_up.text = subTitleArray_Sign_up[curPageInt_Sign_up - 1]
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func pageInit_Sign_up(){
        curBarWidth_Sign_up.constant = pageControllBar_Sign_up.frame.width * curPageCGFloat_Sign_up / 5
    }
    
    func contentUpdate_Sign_up(){
        
    }
    
    @IBAction func nextButtonTap_Sign_up(_ sender: Any){
        if(curPageInt_Sign_up < 5){
            curPageInt_Sign_up += 1
            curPageCGFloat_Sign_up += 1
            pageUpdate_Sign_up()
        }
    }
    
    @IBAction func backButtonTap_Sign_up(_ sender: Any) {
        if(curPageInt_Sign_up > 1){
            curPageInt_Sign_up -= 1
            curPageCGFloat_Sign_up -= 1
            pageUpdate_Sign_up()
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
}
