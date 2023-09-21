//
//  AlarmNChatListViewController.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/01/16.
//

import UIKit

class AlarmNChatListViewController: UIViewController {
    var isFirstPageAlarm: Bool = true
    
    @IBOutlet weak var HomeTabView: UIView!

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var alarmBtn_ANCLV: UIButton!
    @IBOutlet weak var chatBtn_ANCLV: UIButton!
    
    @IBOutlet weak var redAlarmBtnLb: UILabel!
    @IBOutlet weak var redChatBtnLb: UILabel!
    
    @IBOutlet var redBellBtnLb: UILabel!
    
    
    @IBOutlet weak var markLineUIView_ANCLVC: UIView!
    
    @IBOutlet weak var homeTabView_ANCLV: UIView!
    
    @IBOutlet weak var homeBtn_ANCLV: UIButton!
    
    @IBOutlet var homeBtnXConstraint_ANCLV: NSLayoutConstraint!
    @IBOutlet weak var bellBtn_ANCLV: UIButton!
    
    @IBOutlet var bellBtnXConstraint_ANCLV: NSLayoutConstraint!
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
        
        redBellBtnLb.layer.cornerRadius  = redBellBtnLb.layer.frame.size.width/2
        redBellBtnLb.clipsToBounds = true
        
        redAlarmBtnLb.backgroundColor = UIColor(red: 0.996, green: 0.378, blue: 0.187, alpha: 1)
        redChatBtnLb.backgroundColor = UIColor(red: 0.996, green: 0.378, blue: 0.187, alpha: 1)
        
        redBellBtnLb.backgroundColor = UIColor(red: 0.996, green: 0.378, blue: 0.187, alpha: 1)
        
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
        
        
        let screenWidth = UIScreen.main.bounds.size.width
        
        homeBtnXConstraint_ANCLV.constant = screenWidth * 0.496
        bellBtnXConstraint_ANCLV.constant = screenWidth * 0.165
        
        getAllAlarmRead()
        getAllChatRead()
        
        let firstPage = UserDefaults.standard.string(forKey: "alarmOrChat") ?? ""
        if(firstPage == "chat"){
            firstView.alpha = 0
            secondView.alpha = 1
            
            chatBtn_ANCLV.titleLabel?.textColor = clickedColor
            alarmBtn_ANCLV.titleLabel?.textColor = unClickedColor
            
            alarmBtn_ANCLV.setTitleColor(.orange, for: .normal)
            chatBtn_ANCLV.setTitleColor(.orange, for: .normal)
            
            let scale = CGAffineTransform(translationX: 75, y:0)
            self.markLineUIView_ANCLVC.transform = scale
            UserDefaults.standard.set("alarm", forKey: "alarmOrChat")
        }
    }
  
    @objc func chatAlarmDidArrive(_ noti: Notification) {
        print("chat noti 받음")
        isFirstPageAlarm = false
    }
    
    @objc func heartAlarmDidArrive(_ noti: Notification) {
        print("heart noti 받음")
        isFirstPageAlarm = true
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
        let mainSB_Login = UIStoryboard(name: "Main", bundle: nil)
        let homeVC_Login = mainSB_Login.instantiateViewController(withIdentifier: "Home")
        self.navigationController?.pushViewController(homeVC_Login, animated: false)
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
    func getAllAlarmRead(){ // 알림 빨간점 컨트롤 함수
        var rtn: Bool = true
        let defaults = UserDefaults.standard
        
        let likeList = PostAPI.showBoardsLikeList()?.receivedLikeInfo ?? []
        if defaults.object(forKey: "isAlarmAllRead") == nil { // 읽은 날짜가 저장되지 않았을 때 -> 처음 알람을 볼 때
            if likeList.isEmpty{
                redAlarmBtnLb.alpha = 0
            }
            
        }else{
            let lastReadDate = UserDefaults.standard.string(forKey: "isAlarmAllRead")!.toDate()
            
            if !likeList.isEmpty{
                let newDate = likeList[0].likeCreatedAt.toDate()
                rtn = newDate.isNew(fromDate: lastReadDate)
                if(!rtn){
                    redAlarmBtnLb.alpha = 0
                }
            }else{
                redAlarmBtnLb.alpha = 0
            }
        }
    }
    
    func getAllChatRead(){ // 채팅에서 안읽은 메세지 수 계산 함수 -> 처리는 자체 label에서
        var chatArr = PostAPI.getChatList()
        var newMessageNum: Int = 0
        
        if(chatArr == nil){
           chatArr = []
        }
        
        for chatRoom in chatArr ?? []{
            newMessageNum = newMessageNum + chatRoom.notRead
            
        }
        
        // hasnotread가 상대방인지 자신이지 확인하는 조건문 필요
        // 안 읽은 메세지 개수 저장
        UserDefaults.standard.set(newMessageNum, forKey: "NotReadMsgCount")
        
    }
}
