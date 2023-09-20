//
//  chatViewController.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/01/18.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

class ChatViewController: UIViewController {
    
    let db = Firestore.firestore()

    var boardInfo: board_in_chat_result?
    //전 화면에서 얻어야할 값
    var isRead: Bool = false
    public var boardIdx: Int64 = 0
    var isChatExisted: Bool = false // 채팅 목록에서 들어오면 화면전환 전에 이 값을 true로 변경해야함.
    var beforeVC: ChatListViewController?
    var ismyBoard: Bool = false

    var chatDatas_CVC: [Message] = []
    public var chatPersonName = ""
    var chatKey: String = ""
    var partnerEmail: String = ""
    
    @IBOutlet var boardViewHeight: NSLayoutConstraint!
    
    @IBOutlet var nameInBoard: UILabel!
    @IBOutlet var profileViewInBoard: UIView!
    @IBOutlet var contentInBoard: UILabel!
    
    @IBOutlet weak var chatPersonNameLabel_CVC: UILabel!
    
    @IBOutlet weak var chatPersonIdLb_CVC: NSLayoutConstraint!
    @IBOutlet weak var characterView_CVC: Character_UIView!
    
    @IBOutlet weak var idLb_CVC: UILabel!
    @IBOutlet weak var locationLb_CVC: UILabel!
    @IBOutlet weak var timeLb_CVC: UILabel!
    @IBOutlet weak var contentLb_CVC: UILabel!
    
    @IBOutlet weak var postView_CVC: UIView!
    
    @IBOutlet weak var chatTextView_CVC: UITextView!{
        didSet{
            chatTextView_CVC.delegate = self
        }
    }
    private var isOversized = false {
        didSet {
            chatTextView_CVC.isScrollEnabled = isOversized
        }
    }
    private let maxHeight: CGFloat = 45
    
    @IBOutlet weak var inputViewBottomMargin: NSLayoutConstraint!
    @IBOutlet weak var inputUIView_CVC: UIView!
    @IBOutlet weak var chatTableView_CVC: UITableView!{
        didSet{
            chatTableView_CVC.delegate = self
            chatTableView_CVC.dataSource = self
            
            chatTableView_CVC.separatorStyle = .none
        }
    }
    
    @IBAction func moreBtnDidTap(_ sender: Any) {
        self.showAlertController(style: UIAlertController.Style.actionSheet)
    }
    
    
    func showAlertController(style: UIAlertController.Style) {
        let alert = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "닫기", style: .cancel) { (action) in };
        alert.addAction(cancel)
        
        let storyboard_main: UIStoryboard? = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let Report = storyboard_main?.instantiateViewController(identifier: "Report") else { return }
        
        
        let report = UIAlertAction(title: "신고하기",style: UIAlertAction.Style.default, handler:{(action) in
            
            Report.modalPresentationStyle = .fullScreen
            // 화면 전환!
            
            let transition = CATransition()
            transition.duration = 0.3
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            self.view.window!.layer.add(transition, forKey: kCATransition)
            
            self.present(Report, animated: false)
            
        }
        )
        alert.addAction(report)
        
        let block = UIAlertAction(title: "삭제하기", style: UIAlertAction.Style.default, handler:{(action) in
            PostAPI.deleteChat(chatRoomkey: self.chatKey)
            FirestoreAPI.shared.deleteChat(chatRoomID: self.chatKey, completion: {
                error in
                if let error = error {
                    // 삭제 작업 중 오류가 발생한 경우 처리
                    print("삭제 오류: \(error)")
                } else {
                    // 삭제 작업이 성공적으로 완료된 경우 처리
                    print("채팅 삭제 완료")
                }
            })
            self.dismiss(animated: true, completion: {
                self.beforeVC?.refresh()
            })
        }
        )
        
        alert.addAction(block)
        
        
        cancel.setValue(UIColor(red: 0, green: 0, blue: 0, alpha: 1), forKey: "titleTextColor")
        report.setValue(UIColor(red: 0, green: 0, blue: 0, alpha: 1), forKey: "titleTextColor")
        block.setValue(UIColor(red: 0.31, green: 0.494, blue: 0.753, alpha: 1), forKey: "titleTextColor")
        
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
        
        present(alert, animated: true, completion: nil)
    }

    func showBlockAlert(){
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "아니요", style: .cancel) { (action) in }; alert.addAction(cancel)
        let confirm = UIAlertAction(title: "네", style: .default) { (action) in }; alert.addAction(confirm)
        
        confirm.setValue(UIColor(red: 0.563, green: 0.691, blue: 0.883, alpha: 1), forKey: "titleTextColor") //확인버튼 색깔입히기
        cancel.setValue(UIColor(red: 0.663, green: 0.663, blue: 0.663, alpha: 1), forKey: "titleTextColor") //취소버튼 색깔입히기
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        let attributedString = NSAttributedString(string: "해당 사용자를 차단하면 이 채팅은 더이상 볼 수 없습니다.", attributes: [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1)])
        alert.setValue(attributedString, forKey: "attributedTitle") //컨트롤러에 설정한 걸 세팅
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var chatSendBtn_CVC: UIButton!
    
    @IBAction func chatSendBtnDidTap_CVC(_ sender: Any) {
        
        if(isChatExisted == false){
            print("board: \(boardIdx)")
            print("chatKey: \(chatKey)")
            var makeChatStatusCode: Int = 0
            if(ismyBoard == true){
                makeChatStatusCode = PostAPI.makeNewChat(boardIndx: boardIdx, chatRoomKey: chatKey, oppositeEmail: partnerEmail)
                
            }else{
                makeChatStatusCode = PostAPI.makeNewChat(boardIndx: boardIdx, chatRoomKey: chatKey)
            }
            
            print("버튼 클릭: \(makeChatStatusCode)")
            if(makeChatStatusCode == 2000){
                print("채팅방 생성에 성공하였습니다. ")
                isChatExisted = true
                print("partner email: \(partnerEmail)")
                loadMessages()

            }
        }
        
        let chatAlarmStatusCode = PostAPI.sendChatAlarm(emailID : partnerEmail, chatContent: chatTextView_CVC.text, chatRoomKey: chatKey)
        
        
        FirestoreAPI.shared.addChat(chatRoomID: chatKey, chatRequest: Message(content: chatTextView_CVC.text))
        
        // 방법 2 :
        //chatTableView_CVC.insertRows(at: [lastindexPath], with: UITableView.RowAnimation.automatic)
        chatTextView_CVC.text = ""
        
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatSendBtn_CVC.isHidden = true
        postView_CVC.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        postView_CVC.layer.shadowOpacity = 1
        postView_CVC.layer.shadowRadius = 24
        postView_CVC.layer.shadowOffset = CGSize(width: 0, height: 8)
        
        chatTableView_CVC.backgroundColor = UIColor(named: "HandsUpBackGround")
        chatTextView_CVC.isScrollEnabled = false
        
        chatTableView_CVC.register(UINib(nibName: "MyChatTableViewCell", bundle:nil), forCellReuseIdentifier: "MyChatTableViewCell")
        
        // nibName : xib 파일 이름.     forCellReuseIdentifier: Cell의 identifier. xib파일안에서 설정가능
        chatTableView_CVC.register(UINib(nibName: "YourChatTableViewCell", bundle:nil), forCellReuseIdentifier: "YourChatTableViewCell")
        //테이블뷰 높이 설정 - 자동으로
        chatTableView_CVC.rowHeight = UITableView.automaticDimension
        chatTableView_CVC.estimatedRowHeight = 55
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardup), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // 키보드 내려올 때.
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDown), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        postView_CVC.addGestureRecognizer(tapGesture)
        
        swipeRecognizer()
        
        PostAPI.readChat(chatRoomkey: chatKey)
        //채팅 읽은 후 API 요청
        if(isRead == true){
            PostAPI.readChat(chatRoomkey: chatKey)
        }
        refreshBoard()
        let getBoardChatResponse = PostAPI.getBoardInChat(boardIdx: boardIdx)
        boardInfo = getBoardChatResponse?.result
        
        let myUserEmail = UserDefaults.standard.string(forKey: "email")!
        let boardWriter = boardInfo?.writerEmail
        
        if(isChatExisted == false){ // 게시물 비행기 버튼을 통해서 들어온 경우
            if(boardWriter != myUserEmail && boardInfo != nil){ // 게시물 작성자가 내가 아닐 때
                //이미 채팅 내역이 존재하는지 확인
                //chatkey는 게시물 키 + 게시물 작성자 이메일 + 나머지 한명 이메일 값으로 구성
                chatKey = String((boardInfo?.board.boardIdx)!) + boardWriter! + myUserEmail
                var isChatExistedResult: chat_check_rp?
                if(ismyBoard == true){
                    isChatExistedResult = PostAPI.checkChatExists(chatRoomKey: chatKey, boardIdx: (boardInfo?.board.boardIdx) ?? 0, oppositeUserEmail: partnerEmail)!
                }else{
                    isChatExistedResult = PostAPI.checkChatExists(chatRoomKey: chatKey, boardIdx: (boardInfo?.board.boardIdx) ?? 0, oppositeUserEmail: boardWriter!)!
                }

                if(isChatExistedResult!.result.isSaved == true){ //채팅이 이미 존재하는ㄴ 경우
                    isChatExisted = true
                    loadMessages()

                }else{
                    isChatExisted = false
                }
            }
        }
        else{
            //채팅 정보 가져오기
            print("chatkey: \(chatKey)")
            print("가져와짐?")
            loadMessages()
        }
        print("chatkey: \(chatKey)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshBoard()
    }
    func refreshBoard(){
        chatPersonNameLabel_CVC.text = chatPersonName

        //채팅 화면 상단 게시물 설정 코드
        let getBoardChatResponse = PostAPI.getBoardInChat(boardIdx: boardIdx)
        //print(getBoardChatResponse.)
        boardInfo = getBoardChatResponse?.result
        if(boardInfo == nil){
            self.postView_CVC.isHidden = true

            self.boardViewHeight.constant = 0
        }
        else if (getBoardChatResponse?.statusCode == 4053){
            self.postView_CVC.isHidden = true
            self.boardViewHeight.constant = 0
        }
        else{
            nameInBoard.text = boardInfo?.nickname
            contentInBoard.text = boardInfo?.board.content
            
            var boardsCharacterList: [Int] = []
                
            let background = (Int(boardInfo!.character.backGroundColor) ?? 1) - 1
            let hair = (Int(boardInfo!.character.hair) ?? 1) - 1
            let eyebrow = (Int(boardInfo!.character.eyeBrow) ?? 1) - 1
            let mouth = (Int(boardInfo!.character.mouth) ?? 1) - 1
            let nose = (Int(boardInfo!.character.nose) ?? 1) - 1
            let eyes = (Int(boardInfo!.character.eye) ?? 1) - 1
            let glasses = Int(boardInfo!.character.glasses) ?? 0
            
            boardsCharacterList.append(background)
            boardsCharacterList.append(hair)
            boardsCharacterList.append(eyebrow)
            boardsCharacterList.append(mouth)
            boardsCharacterList.append(nose)
            boardsCharacterList.append(eyes)
            boardsCharacterList.append(glasses)
            print("boardlre: \(boardsCharacterList)")
            characterView_CVC.setAll(componentArray: boardsCharacterList) // 가져오기
            characterView_CVC.setCharacter_NoShadow() // 그림자 없애기
            characterView_CVC.setCharacter() // 캐릭터 생성
        }
    }
    
    @IBAction func backBtnDidTap(_ sender: Any) {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: {
            self.beforeVC?.refresh()
        })
    }
    
    func swipeRecognizer() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction{
            case UISwipeGestureRecognizer.Direction.right:
                // 스와이프 시, 원하는 기능 구현.
                let transition: CATransition = CATransition()
                transition.duration = 0.3
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition.type = CATransitionType.reveal
                transition.subtype = CATransitionSubtype.fromLeft
                self.view.window!.layer.add(transition, forKey: nil)
                self.dismiss(animated: true, completion: {
                    PostAPI.readChat(chatRoomkey: self.chatKey)
                    self.beforeVC?.refresh()
                    
                })
            default: break
            }
        }
    }
    
 
    private func loadMessages() {
        db.collection("chatroom/\(chatKey)/chat").order(by: "createdat", descending: false).addSnapshotListener { (querySnapshot, error) in
            
            self.chatDatas_CVC = []
            if let e = error {
                print(e.localizedDescription)
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    snapshotDocuments.forEach { (doc) in
                        let data = doc.data()
                        if let content = data["content"] as? String, let authorUID = data["author_uid"] as? String, let createdat = data["createdat"] as? String {
                            self.chatDatas_CVC.append(Message(documentID: "", content: content, authorUID: authorUID, createdat: createdat))
                            
                            
                            DispatchQueue.main.async {
                                self.chatTableView_CVC.reloadData()
                                self.chatTableView_CVC.scrollToRow(at: IndexPath(row: self.chatDatas_CVC.count-1, section: 0), at: .top, animated: false)
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    func setupBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = view.frame
        view.addSubview(visualEffectView)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        // 스토리보드에서 지정해준 ViewController의 ID
        
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "PostThroughChatViewController") as? PostThroughChatViewController else { return  }
        nextVC.boardIdx = boardIdx
        nextVC.beforeVC = self
        nextVC.modalPresentationStyle = .overCurrentContext
        // 화면 전환!
        self.present(nextVC, animated: true)
    }
    
    @objc func keyBoardup(noti: Notification){
        let notiInfo = noti.userInfo!
        let keyboardFrame = notiInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        
        // 홈 버튼 없는 아이폰들은 다 빼줘야함.
        let height = keyboardFrame.size.height - self.view.safeAreaInsets.bottom
        let animationDuration = notiInfo[ UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        // 키보드 올라오는 애니메이션이랑 동일하게 텍스트뷰 올라가게 만들기.
        UIView.animate(withDuration: animationDuration) {
            self.inputViewBottomMargin.constant = height
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyBoardDown(noti: Notification){
        let notiInfo = noti.userInfo!
        let animationDuration = notiInfo[ UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        UIView.animate(withDuration: animationDuration) {
            self.inputViewBottomMargin.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func getNowTime() -> String {
        var formatter_time = DateFormatter()
        formatter_time.dateFormat = "HH:mm a"
        formatter_time.amSymbol = "AM"
        formatter_time.pmSymbol = "PM"
        var current_time_string = formatter_time.string(from: Date())
        
        return current_time_string
    }
    
    func formatDate(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let outputFormatter = DateFormatter()
        
        let date = inputFormatter.date(from: dateString)
        
        if let date = date {
            let calendar = Calendar.current
            let currentDate = Date()
            
            let currentYear = calendar.component(.year, from: currentDate)
            let inputYear = calendar.component(.year, from: date)
            
            if currentYear == inputYear {
                if calendar.isDateInToday(date) {
                    outputFormatter.dateFormat = "h:mm a"
                } else {
                    outputFormatter.dateFormat = "M/dd hh:mm"
                }
            } else {
                outputFormatter.dateFormat = "yyyy/M/dd hh:mm"
            }
            
            return outputFormatter.string(from: date)
        }
        
        return ""
    }
    
}

extension ChatViewController: UITextViewDelegate{
    
    // 메세지 입력창 textview의 height autosizing
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = chatTextView_CVC.sizeThatFits(size)
        chatTextView_CVC.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = chatTextView_CVC.text ?? ""
        guard let stringRange = Range(range, in: currentText)else { return false}
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        let text_count = changedText.count
        
        // textview에 입력된 글자가 없을 때 입력 버튼 숨기기
        if(text_count > 0){
            chatSendBtn_CVC.isHidden = false
        }
        else if (text_count == 0){
            chatSendBtn_CVC.isHidden = true
        }
        
        if(text == "\n") {
            //            if chatTextView_CVC.text != ""{
            //                chatDatas_CVC.append(chatTextView_CVC.text)
            //                chatTextView_CVC.text = ""
            //            }
            
            
        }
        return changedText.count >= 0
        
        
        
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatDatas_CVC.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userEmail = UserDefaults.standard.string(forKey: "email")!
     
        if userEmail == chatDatas_CVC[indexPath.row].authorUID {
            
            let myCell = tableView.dequeueReusableCell(withIdentifier: "MyChatTableViewCell", for: indexPath) as! MyChatTableViewCell
            // MyCell 형식으로 사용하기 위해 형변환이 필요하다.
            myCell.contentTV_MCTVC.text = chatDatas_CVC[indexPath.row].content
            myCell.timeLb_MCTVC.text = chatDatas_CVC[indexPath.row].createdat
            
            // 입력된 문자열을 Date 객체로 변환
//            let date = inputFormatter.date(from: chatDatas_CVC[indexPath.row].createdat)
//                // Date 객체를 지정된 형식으로 문자열로 변환
//            let formattedTime = outputFormatter.string(from: date!)
                myCell.timeLb_MCTVC.text = formatDate(chatDatas_CVC[indexPath.row].createdat)
                
            // 버튼 누르면 chatDatas 에 텍스트를 넣을 것이기 때문에 거기서 꺼내오면 되는거다.
            myCell.selectionStyle = .none
            return myCell
            
        }
        else{
            
            let yourCell = tableView.dequeueReusableCell(withIdentifier: "YourChatTableViewCell", for: indexPath) as! YourChatTableViewCell
            // 이것도 마찬가지.
            yourCell.contentTV_YCTVC.text = chatDatas_CVC[indexPath.row].content
            
//            let date = inputFormatter.date(from: chatDatas_CVC[indexPath.row].createdat)!
//                // Date 객체를 지정된 형식으로 문자열로 변환
//                let formattedTime = outputFormatter.string(from: date)
            yourCell.timeLb_YCTVC.text = formatDate(chatDatas_CVC[indexPath.row].createdat)
            yourCell.selectionStyle = .none
            return yourCell
            
        }
    }
    
    
    
}
