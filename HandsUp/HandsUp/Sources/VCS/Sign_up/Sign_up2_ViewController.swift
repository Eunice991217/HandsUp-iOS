//
//  Sign_up2_ViewController.swift
//  HandsUp
//
//  Created by 황재상 on 2023/01/08.
//

import UIKit

class Sign_up2_ViewController: UIViewController {

    @IBOutlet weak var curPageBarX_Sign_up2: NSLayoutConstraint!
    @IBOutlet weak var curPageBarWidth_Sign_up2: NSLayoutConstraint!
    @IBOutlet weak var pageControlView_Sign_up2: RoundedShadow_UIView!
    @IBOutlet weak var titleLable_Sign_up2: UILabel!
    @IBOutlet weak var schoolPickerView_Sign_up2: UIPickerView!
    var sign_upData_Sign_up2 : SignupData = SignupData()
    var schoolList_Sign_up2: [String] = ["서울대학교", "가천대학교", "건국대학교"]
    
    func pageBarInit_Sign_up2(){
        let widthValue_Sign_up2 = pageControlView_Sign_up2.frame.size.width * 2 / 5
        curPageBarX_Sign_up2.constant = 0
        curPageBarWidth_Sign_up2.constant = widthValue_Sign_up2 as CGFloat
    }
    
    @IBAction func nextButtonTap_Sign_up2(_ sender: Any) {
        if(sign_upData_Sign_up2.type == 0){
            let emailSign_upVC_Sign_up2 = self.storyboard?.instantiateViewController(withIdentifier: "EmailSign_up") as! EmailSign_up_ViewController
            emailSign_upVC_Sign_up2.sign_upData_EmailSign_up = sign_upData_Sign_up2
            self.navigationController?.pushViewController(emailSign_upVC_Sign_up2, animated: false)
        }else{
            let socialLogin_upVC_Sign_up2 = self.storyboard?.instantiateViewController(withIdentifier: "SocialLogin") as! SocialLogin_ViewController
            socialLogin_upVC_Sign_up2.sign_upData_SocialLogin = sign_upData_Sign_up2
            self.navigationController?.pushViewController(socialLogin_upVC_Sign_up2, animated: false)
        }
    }
    
    func pickerViewInit(){
        sign_upData_Sign_up2.school = schoolList_Sign_up2[0]
        schoolPickerView_Sign_up2.delegate = self
        schoolPickerView_Sign_up2.dataSource = self
    }
    
    func titleInit_Sign_up2(){
     titleLable_Sign_up2.text = "다니시는 대학교\n선택해주세요"
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func viewWillLayoutSubviews() {
        schoolPickerView_Sign_up2.subviews[1].backgroundColor = .clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleInit_Sign_up2()
        pageBarInit_Sign_up2()
        pickerViewInit()

    }
}

extension Sign_up2_ViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let selectView_Sign_up2 = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 52))
        let schoolLabel_Sign_up2 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 52))
        schoolLabel_Sign_up2.text = schoolList_Sign_up2[row]
        schoolLabel_Sign_up2.textAlignment = .center
        schoolLabel_Sign_up2.font = UIFont(name: "Roboto-Bold", size: 16)
        schoolLabel_Sign_up2.textColor = UIColor(named: "HandUpMainText")
        
        selectView_Sign_up2.addSubview(schoolLabel_Sign_up2)
        return selectView_Sign_up2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return schoolList_Sign_up2.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sign_upData_Sign_up2.school = schoolList_Sign_up2[row]
    }
}
