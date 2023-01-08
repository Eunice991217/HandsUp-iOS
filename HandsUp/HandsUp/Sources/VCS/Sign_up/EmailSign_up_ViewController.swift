//
//  EmailSign_up_ViewController.swift
//  HandsUp
//
//  Created by 황재상 on 2023/01/08.
//

import UIKit

class EmailSign_up_ViewController: UIViewController {

    @IBOutlet weak var curPageBarX_EmailSign_up: NSLayoutConstraint!
    @IBOutlet weak var curPageBarWidth_EmailSign_up: NSLayoutConstraint!
    @IBOutlet weak var pageControlView_EmailSign_up: RoundedShadow_UIView!
    @IBOutlet weak var titleLable_EmailSign_up: UILabel!
    @IBOutlet weak var subTitleLabe_EmailSign_up: UILabel!
    
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
    @IBAction func nextButtonTap_EmailSign_up(_ sender: Any) {
        let nicknameVC_EmailSign_up = self.storyboard?.instantiateViewController(withIdentifier: "Nickname")
        self.navigationController?.pushViewController(nicknameVC_EmailSign_up!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleInit_EmailSign_up()
        pageBarInit_EmailSign_up()
        self.hideKeyboard()
    }
    
    
}
