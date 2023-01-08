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
    
    func pageBarInit(){
        let widthValue_Sign_up2 = pageControlView_Sign_up2.frame.size.width / 6
        curPageBarX_Sign_up2.constant = widthValue_Sign_up2
        curPageBarWidth_Sign_up2.constant = widthValue_Sign_up2 as CGFloat
    }
    
    func titleInit(){
     titleLable_Sign_up2.text = "다니시는 대학교\n선택해주세요"
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleInit()
        pageBarInit()
    }
    
    


}
