//
//  chatViewController.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/01/18.
//

import UIKit

class ChatViewController: UIViewController {
    
    var chatRoomKey: String = ""
    var boardsCharacterList: [Int] = []
    var chatDatas_CVC: [Message] = []
    public var chatPersonName = ""
    public var statusCode = 0
    public var boardIdx: Int = 0
    
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
        
        let block = UIAlertAction(title: "차단하기", style: UIAlertAction.Style.default, handler:{(action) in self.showBlockAlert()}
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
        //        if chatTextView_CVC.text != ""{
        //            chatDatas_CVC.append(chatTextView_CVC.text)
        //            chatTextView_CVC.text = ""
        //        }
        
        let lastindexPath = IndexPath(row: chatDatas_CVC.count - 1, section: 0)
        
        // 방법 1 : chatTableView.reloadData() 리로드는 조금 부자연스럽다.
        // 방법 2 :
        chatTableView_CVC.insertRows(at: [lastindexPath], with: UITableView.RowAnimation.automatic)
        
        // inputTextViewHeight.constant = 35
        
        // TableView에는 원하는 곳으로 이동하는 함수가 있다. 고로 전송할때마다 최신 대화로 이동.
        chatTableView_CVC.scrollToRow(at: lastindexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        
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
        
        
        let boardInfo = PostAPI.getBoardInChat(boardIdx: boardIdx)
        chatPersonNameLabel_CVC.text = boardInfo?.nickname
        nameInBoard.text = boardInfo?.nickname
        contentInBoard.text = boardInfo?.board.content
        
        boardsCharacterList = []
        
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
        
        characterView_CVC.setAll(componentArray: boardsCharacterList) // 가져오기
        characterView_CVC.setCharacter_NoShadow() // 그림자 없애기
        characterView_CVC.setCharacter() // 캐릭터 생성
        
        
        //  chatDatas_CVC = FirestoreAPI.shared.readAll(chatRoomID: "wltjd3459@af dfs") ?? []
        print("채팅 메세지 개수: \(chatDatas_CVC.count)")
        
    }
    
    @IBAction func backBtnDidTap(_ sender: Any) {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
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
                self.dismiss(animated: true, completion: nil)
            default: break
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
            
            let lastindexPath = IndexPath(row: chatDatas_CVC.count - 1, section: 0)
            
            // 방법 1 : chatTableView.reloadData() 리로드는 조금 부자연스럽다.
            // 방법 2 :
            chatTableView_CVC.insertRows(at: [lastindexPath], with: UITableView.RowAnimation.automatic)
            
            // inputTextViewHeight.constant = 35
            
            // TableView에는 원하는 곳으로 이동하는 함수가 있다. 고로 전송할때마다 최신 대화로 이동.
            chatTableView_CVC.scrollToRow(at: lastindexPath, at: UITableView.ScrollPosition.bottom, animated: true)
            
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
            // 버튼 누르면 chatDatas 에 텍스트를 넣을 것이기 때문에 거기서 꺼내오면 되는거다.
            myCell.selectionStyle = .none
            return myCell
            
        }
        else{
            
            let yourCell = tableView.dequeueReusableCell(withIdentifier: "YourChatTableViewCell", for: indexPath) as! YourChatTableViewCell
            // 이것도 마찬가지.
            yourCell.contentTV_YCTVC.text = chatDatas_CVC[indexPath.row].content
            yourCell.timeLb_YCTVC.text = getNowTime()
            yourCell.selectionStyle = .none
            return yourCell
            
        }
    }
    
}
