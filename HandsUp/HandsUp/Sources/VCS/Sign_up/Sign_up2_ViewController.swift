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
    
    func pageBarInit_Sign_up2(){
        let widthValue_Sign_up2 = pageControlView_Sign_up2.frame.size.width / 5
        curPageBarX_Sign_up2.constant = widthValue_Sign_up2
        curPageBarWidth_Sign_up2.constant = widthValue_Sign_up2 as CGFloat
    }
    
    @IBAction func nextButtonTap_Sign_up2(_ sender: Any) {
        let emailSign_upVC_Sign_up2 = self.storyboard?.instantiateViewController(withIdentifier: "SocialLogin")
        self.navigationController?.pushViewController(emailSign_upVC_Sign_up2!, animated: true)
    }
    func titleInit_Sign_up2(){
     titleLable_Sign_up2.text = "다니시는 대학교\n선택해주세요"
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleInit_Sign_up2()
        pageBarInit_Sign_up2()
    }
    
    


}
