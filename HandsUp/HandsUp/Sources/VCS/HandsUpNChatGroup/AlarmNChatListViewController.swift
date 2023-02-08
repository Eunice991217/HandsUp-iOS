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
    
    @IBOutlet weak var homeTabView_ANCLV: UIView!
    
    @IBOutlet weak var homeBtn_ANCLV: UIButton!
    
    @IBOutlet weak var bellBtn_ANCLV: UIButton!
    
    let safeAreaView = UIView()
    var bomttomSafeAreaInsets: CGFloat = 0.0
    
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
        
        homeTabView_ANCLV.clipsToBounds = false
        homeTabView_ANCLV.layer.cornerRadius = 40
        homeTabView_ANCLV.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
        homeTabView_ANCLV.layer.shadowOpacity = 1
        homeTabView_ANCLV.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        homeTabView_ANCLV.layer.shadowOffset = CGSize(width: 0, height: -8)
        homeTabView_ANCLV.layer.shadowRadius = 24
        homeTabView_ANCLV.layer.masksToBounds = false
        
        configureCustomView()
        
        self.safeAreaView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.safeAreaView)
        
        self.safeAreaView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            self.safeAreaView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.safeAreaView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.safeAreaView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.safeAreaView.heightAnchor.constraint(equalToConstant: bomttomSafeAreaInsets)
        ])
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
    
    @IBAction func homeBtnDidTap(_ sender: Any) {
        bellBtn_ANCLV.setImage(UIImage(named: "notifications"), for: .normal)
        
        self.dismiss(animated: false)
    }
    
    
    @IBAction func bellBtnDidTap(_ sender: Any) {
        homeBtn_ANCLV.setImage(UIImage(named: "HomeIcon"), for: .normal)
        bellBtn_ANCLV.setImage(UIImage(named: "notificationsDidTap"), for: .normal)
        
    }
    
    @IBAction func plusBtnDidTap(_ sender: Any) {
        
        guard let registerPostVC = self.storyboard?.instantiateViewController(identifier: "RegisterPostViewController") else {
            return
        }
        // 화면 전환!
        self.present(registerPostVC, animated: true)
    }
    
    func configureCustomView() {
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        if let hasWindowScene = windowScene {
            bomttomSafeAreaInsets = hasWindowScene.windows.first?.safeAreaInsets.bottom ?? 0
        }
    
    }
}
