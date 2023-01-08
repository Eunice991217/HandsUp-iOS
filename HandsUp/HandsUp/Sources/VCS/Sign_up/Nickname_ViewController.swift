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
    
    func titleInit_Nickname(){
        titleLable_Nickname.text = "닉네임을\n만들어보세요"
        subTitleLabe_Nickname.text = "닉네임은 7일후 변경가능하니 신중히\n선택해주세요:)"
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func pageBarInit_Nickname(){
        let widthValue_Nickname = pageControlView_Nickname.frame.size.width / 5
        curPageBarX_Nickname.constant = widthValue_Nickname * 3
        curPageBarWidth_Nickname.constant = widthValue_Nickname as CGFloat
    }
    
    @IBAction func nextButtonTap_Nickname(_ sender: Any) {
        let profileVC_Nickname = self.storyboard?.instantiateViewController(withIdentifier: "Profile")
        self.navigationController?.pushViewController(profileVC_Nickname!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleInit_Nickname()
        pageBarInit_Nickname()
    }
    
}
