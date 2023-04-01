//
//  ChatListViewController.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/01/16.
//

import UIKit

class ChatListViewController: UIViewController {


    @IBOutlet weak var chatAlarmTableView_CLVC: UITableView!
    var chatArr: [Chat]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatAlarmTableView_CLVC.delegate = self
        chatAlarmTableView_CLVC.dataSource = self
        chatAlarmTableView_CLVC.rowHeight = 84
        
        
        chatAlarmTableView_CLVC.backgroundColor = UIColor(named: "HandsUpBackGround")
        // Do any additional setup after loading the view.
        
        chatArr = PostAPI.getChatList()
        if( chatArr == nil){
            chatArr = []
            showBlockAlert()
        }
    }
    
    
    func showBlockAlert(){
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .default) { (action) in }; alert.addAction(confirm)

        confirm.setValue(UIColor(red: 0.563, green: 0.691, blue: 0.883, alpha: 1), forKey: "titleTextColor") //확인버튼 색깔입히기
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        let attributedString = NSAttributedString(string: "채팅정보를 가져오는데 실패하였습니다.", attributes: [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1)])
        alert.setValue(attributedString, forKey: "attributedTitle") //컨트롤러에 설정한 걸 세팅

        present(alert, animated: false, completion: nil)
    }
    
    func getAllAlarmRead(){ //새로운 알람이 있으면 false을 리턴하는 함수
        let defaults = UserDefaults.standard
        let alarmNchatVC = self.storyboard?.instantiateViewController(withIdentifier: "AlarmNChatListViewController") as! AlarmNChatListViewController
        alarmNchatVC.redBellBtnLb.alpha = 0
        defaults.set(Date().toString(), forKey:"isAlarmAllRead")
    }


}

extension ChatListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return chatArr!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatAlarmTableViewCell", for: indexPath) as! ChatAlarmTableViewCell
        
        cell.characterView_CATVC.setCharacter_NoShadow()

        cell.timeLb_CATVC.text = chatArr![indexPath.row].character.createdAt
        cell.idLb_CATVC.text = chatArr![indexPath.row].nickname
       // cell.contentLb_CATVC.text = chatArr![indexPath.row].message
        
      //  cell.countLb_CATVX.text = String(chatArr![indexPath.row].newMsgCount)
 //       if(chatArr![indexPath.row].newMsgCount == 0 ){
 //           cell.countLb_CATVX.isHidden = true
 //       }
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController else { return  }
        
        nextVC.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        
    
        present(nextVC, animated: false, completion: nil)
        
    }
    
}
