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
   // var beforeVC: AlarmListViewController?
    
    @IBOutlet var redLabelOnBell: UILabel!
    
    @IBOutlet var redLabelOnChat: UILabel!
    var beforeVC: AlarmListViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatAlarmTableView_CLVC.delegate = self
        chatAlarmTableView_CLVC.dataSource = self
        chatAlarmTableView_CLVC.allowsMultipleSelectionDuringEditing = false
        chatAlarmTableView_CLVC.rowHeight = 84
        
        
        chatAlarmTableView_CLVC.backgroundColor = UIColor(named: "HandsUpBackGround")
        
        self.view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)

        refresh()
        
        if hasNewerChat() || hasNewerAlarm() {
            redLabelOnBell.isHidden = false
        }else {
            redLabelOnBell.isHidden = true
        }
        if(hasNewerChat()){
            redLabelOnChat.isHidden = false
        }else{
            redLabelOnChat.isHidden = true
        }
        

    }
    func refresh(){
        chatArr = PostAPI.getChatList()
        if( chatArr == nil){
            chatArr = []
            showBlockAlert()
        }
        chatAlarmTableView_CLVC.reloadData()
    }
    @IBAction func alarmBtnDidTap(_ sender: Any) {
        
        self.dismiss(animated: false, completion: {
            self.beforeVC?.refresh()
        })
    }
    
    @IBAction func postBtnDidTap(_ sender: Any) {
        guard let registerPostVC = self.storyboard?.instantiateViewController(identifier: "RegisterPostViewController") else {
            return
        }
        // 화면 전환!
        self.present(registerPostVC, animated: true)
    }
    
    @IBAction func homeBtnDidTap(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
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
        
        let character = chatArr![indexPath.row].character
        var boardsCharacterList: [Int] = []
        
        let background = (Int(character.backGroundColor) ?? 1) - 1
        let hair = (Int(character.hair) ?? 1) - 1
        let eyebrow = (Int(character.eyeBrow) ?? 1) - 1
        let mouth = (Int(character.mouth) ?? 1) - 1
        let nose = (Int(character.nose) ?? 1) - 1
        let eyes = (Int(character.eye) ?? 1) - 1
        let glasses = Int(character.glasses) ?? 0
        
        boardsCharacterList.append(background)
        boardsCharacterList.append(hair)
        boardsCharacterList.append(eyebrow)
        boardsCharacterList.append(mouth)
        boardsCharacterList.append(nose)
        boardsCharacterList.append(eyes)
        boardsCharacterList.append(glasses)
        
        print("비교해보자 \(chatArr![indexPath.row].nickname):  \(boardsCharacterList)")
        cell.characterView_CATVC.setAll(componentArray: boardsCharacterList) // 가져오기
        cell.characterView_CATVC.setCharacter_NoShadow() // 그림자 없애기
        cell.characterView_CATVC.setCharacter() // 캐릭터 생성

        cell.timeLb_CATVC.text = formatDateString(chatArr![indexPath.row].updatedAt)
        cell.idLb_CATVC.text = chatArr![indexPath.row].nickname
        cell.contentLb_CATVC.text = chatArr![indexPath.row].lastContent
        
        let userEmail = UserDefaults.standard.string(forKey: "email")!
        if(chatArr![indexPath.row].lastSenderEmail != userEmail ){ // 상대방이 마지막으로 보냈을 때
            if(chatArr![indexPath.row].notRead > 0){
                cell.countLb_CATVX.isHidden = false
                cell.countLb_CATVX.text = String(chatArr![indexPath.row].notRead)
            }else{
                cell.countLb_CATVX.isHidden = true

            }
        }
        else{
            cell.countLb_CATVX.isHidden = true
            
        }
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController else { return  }
        let userEmail = UserDefaults.standard.string(forKey: "email")!
        if(chatArr![indexPath.row].lastSenderEmail != userEmail && chatArr![indexPath.row].notRead > 0){
            nextVC.isRead = false
        }
        nextVC.isChatExisted = true
        nextVC.boardIdx = Int64(chatArr![indexPath.row].boardIdx)
        nextVC.chatKey = chatArr![indexPath.row].chatRoomKey
      //  nextVC.boardIdx = nextVC.boardIdx = Int(boardIndex!)
        nextVC.beforeVC = self
        
        nextVC.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        
       // self.navigationController?.pushViewController(nextVC, animated: true)
        present(nextVC, animated: false)
        
    }
    
    
}
extension UIViewController {
    func formatDateString(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        
        if let date = dateFormatter.date(from: dateString) {
            let currentDate = Date()
            let calendar = Calendar.current
            
            // 조건 1: 3분 이내면 '방금 전'
            if currentDate.timeIntervalSince(date) < 180 {
                return "방금 전"
            }
            
            // 조건 2: 오늘 날짜면 시간만 나오도록
            if calendar.isDateInToday(date) {
                dateFormatter.dateFormat = "HH:mm"
                return dateFormatter.string(from: date)
            }
            
            // 조건 3: 올해이고 오늘이 아니면 03/18 07:57
            if calendar.isDate(date, equalTo: currentDate, toGranularity: .year) && !calendar.isDateInToday(date) {
                dateFormatter.dateFormat = "MM/dd HH:mm"
                return dateFormatter.string(from: date)
            }
            
            // 조건 4: 올해가 아니면 2023/03/18 07:57
            dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
            return dateFormatter.string(from: date)
        }
        
        return "날짜 변환 실패"
    }
}
