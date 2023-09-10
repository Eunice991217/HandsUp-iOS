//
//  ChatListViewController.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/01/16.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

class ChatListViewController: UIViewController {

    let db = Firestore.firestore()
    @IBOutlet weak var chatAlarmTableView_CLVC: UITableView!
    var chatArr: [Chat]?
    var chatDatas_CVC: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatAlarmTableView_CLVC.delegate = self
        chatAlarmTableView_CLVC.dataSource = self
        chatAlarmTableView_CLVC.allowsMultipleSelectionDuringEditing = false
        chatAlarmTableView_CLVC.rowHeight = 84
        
        
        chatAlarmTableView_CLVC.backgroundColor = UIColor(named: "HandsUpBackGround")
 
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
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 삭제할 데이터와 셀을 찾습니다.
            guard let chatArray = chatArr, indexPath.row < chatArray.count else {
                print("유효하지 않은 인덱스 또는 chatArr이 nil입니다.")
                return
            }

            let itemToDelete = chatArray[indexPath.row]

            // chatArr 업데이트
            chatArr?.remove(at: indexPath.row)

            // 테이블 뷰에서 셀을 삭제합니다.
            tableView.deleteRows(at: [indexPath], with: .fade) // 또는 .automatic, .none을 사용할 수 있습니다.

            // 삭제된 아이템에 대한 추가 작업 (예: 네트워크 요청 등)
            PostAPI.deleteChat(chatRoomkey: itemToDelete.chatRoomKey)
            FirestoreAPI.shared.deleteChat(chatRoomID: itemToDelete.chatRoomKey, completion: {
                error in
                   if let error = error {
                       // 삭제 작업 중 오류가 발생한 경우 처리
                       print("삭제 오류: \(error)")
                   } else {
                       // 삭제 작업이 성공적으로 완료된 경우 처리
                       print("채팅 삭제 완료")
                   }
            })
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return chatArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatAlarmTableViewCell", for: indexPath) as! ChatAlarmTableViewCell
        
        cell.characterView_CATVC.setCharacter_NoShadow()

        cell.timeLb_CATVC.text = chatArr![indexPath.row].character.createdAt
        cell.idLb_CATVC.text = chatArr![indexPath.row].nickname
        cell.contentLb_CATVC.text = chatArr![indexPath.row].lastContent
        
        let userEmail = UserDefaults.standard.string(forKey: "email")!
        if(chatArr![indexPath.row].lastSenderEmail != userEmail){
            cell.countLb_CATVX.isHidden = true
        }
        else{
            if(chatArr![indexPath.row].notRead > 0){
                cell.countLb_CATVX.isHidden = false
                cell.countLb_CATVX.text = String(chatArr![indexPath.row].notRead)
            }
        }

        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController else { return  }
        let userEmail = UserDefaults.standard.string(forKey: "email")!
        if(chatArr![indexPath.row].lastSenderEmail != userEmail && chatArr![indexPath.row].notRead > 0){
            nextVC.isRead = true
        }
        nextVC.isChatExisted = true
        nextVC.boardIdx = chatArr![indexPath.row].boardIdx
        nextVC.chatKey = chatArr![indexPath.row].chatRoomKey
      //  nextVC.boardIdx = nextVC.boardIdx = Int(boardIndex!)
        
        nextVC.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        
    
        present(nextVC, animated: false, completion: nil)
        
    }
    
}
