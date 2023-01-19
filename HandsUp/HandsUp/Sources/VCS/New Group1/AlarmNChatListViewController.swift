//
//  AlarmNChatListViewController.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/01/16.
//

import UIKit

class AlarmNChatListViewController: UIViewController {

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var alarmBtn_ANCLV: UIButton!
    @IBOutlet weak var chatBtn_ANCLV: UIButton!
    
    @IBOutlet weak var redAlarmBtnLb: UILabel!
    
    
    @IBOutlet weak var redChatBtnLb: UILabel!
    
    @IBOutlet weak var markLineUIView_ANCLVC: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        alarmBtn_ANCLV.titleLabel?.textColor = clickedColor
        chatBtn_ANCLV.titleLabel?.textColor = unClickedColor
        
        redAlarmBtnLb.layer.cornerRadius  = redAlarmBtnLb.layer.frame.size.width/2
        redAlarmBtnLb.clipsToBounds = true
        
        redChatBtnLb.layer.cornerRadius  = redChatBtnLb.layer.frame.size.width/2
        redChatBtnLb.clipsToBounds = true
        
        redAlarmBtnLb.backgroundColor = UIColor(red: 0.996, green: 0.378, blue: 0.187, alpha: 1)
        redChatBtnLb.backgroundColor = UIColor(red: 0.996, green: 0.378, blue: 0.187, alpha: 1)
        
        
        // Do any additional setup after loading the view.
    }
    
    let unClickedColor = UIColor(named: "HandsUpDarkGrey")
    let clickedColor = UIColor(named: "HandsUpMainText")
    
    @IBAction func alarmBtnDidTap(_ sender: UISegmentedControl) {
        firstView.alpha = 1
        secondView.alpha = 0
        
        //alarmBtn_ANCLV.setTitleColor(clickedColor, for: .normal)
        //chatBtn_ANCLV.setTitleColor(unClickedColor, for: .normal)
        
        alarmBtn_ANCLV.titleLabel?.textColor = clickedColor
        chatBtn_ANCLV.titleLabel?.textColor = unClickedColor
        
        markLineUIView_ANCLVC.frame = CGRect(x: 16, y: 104, width: 50, height: 2)
        
        UIView.animate(withDuration: 0.2) {

            let scale = CGAffineTransform(translationX: 0, y:0)
                self.markLineUIView_ANCLVC.transform = scale
               }
        
    }
    
    @IBAction func chatBtnDidTap(_ sender: UISegmentedControl) {
        firstView.alpha = 0
        secondView.alpha = 1
        
        chatBtn_ANCLV.titleLabel?.textColor = clickedColor
        alarmBtn_ANCLV.titleLabel?.textColor = unClickedColor
        
        alarmBtn_ANCLV.setTitleColor(.orange, for: .normal)
       chatBtn_ANCLV.setTitleColor(.orange, for: .normal)
        
        UIView.animate(withDuration: 0.2) {
            let scale = CGAffineTransform(translationX: 75, y:0)
                self.markLineUIView_ANCLVC.transform = scale
               }

    }
}
