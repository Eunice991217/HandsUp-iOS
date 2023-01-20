//
//  chatViewController.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/01/18.
//

import UIKit

class ChatViewController: UIViewController, UITextViewDelegate {

    var chatDatas_CVC = [String]()
    
    @IBOutlet weak var chatPersonIdLb_CVC: NSLayoutConstraint!
    @IBOutlet weak var charImgView_CVC: UIImageView!
    
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
  //  @IBOutlet weak var chatTextViewHeight_CVC: NSLayoutConstraint!
    
    @IBOutlet weak var inputViewBottomMargin: NSLayoutConstraint!
    @IBOutlet weak var inputUIView_CVC: UIView!
    @IBOutlet weak var chatTableView_CVC: UITableView!{
        didSet{
            chatTableView_CVC.delegate = self
            chatTableView_CVC.dataSource = self
            
            chatTableView_CVC.separatorStyle = .none
        }
    }
    @IBOutlet weak var chatSendBtn_CVC: UIButton!
    
    @IBAction func chatSendBtnDidTap_CVC(_ sender: Any) {
        if chatTextView_CVC.text != ""{
            chatDatas_CVC.append(chatTextView_CVC.text)
            chatTextView_CVC.text = ""
        }
        
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
        
        postView_CVC.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        postView_CVC.layer.shadowOpacity = 1
        postView_CVC.layer.shadowRadius = 24
        postView_CVC.layer.shadowOffset = CGSize(width: 0, height: 8)

        
        chatTableView_CVC.register(UINib(nibName: "MyChatTableViewCell", bundle:nil), forCellReuseIdentifier: "MyChatTableViewCell")
        // nibName : xib 파일 이름.     forCellReuseIdentifier: Cell의 identifier. xib파일안에서 설정가능
        chatTableView_CVC.register(UINib(nibName: "YourChatTableViewCell", bundle:nil), forCellReuseIdentifier: "YourChatTableViewCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardup), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // 키보드 내려올 때.
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDown), name: UIResponder.keyboardDidHideNotification, object: nil)
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
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatDatas_CVC.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0{
                    
                    let myCell = tableView.dequeueReusableCell(withIdentifier: "MyChatTableViewCell", for: indexPath) as! MyChatTableViewCell
                    // MyCell 형식으로 사용하기 위해 형변환이 필요하다.
                    myCell.contentTV_MCTVC.text = chatDatas_CVC[indexPath.row]   // 버튼 누르면 chatDatas 에 텍스트를 넣을 것이기 때문에 거기서 꺼내오면 되는거다.
                    myCell.selectionStyle = .none
                    return myCell
                    
                }
                else{
                    
                    let yourCell = tableView.dequeueReusableCell(withIdentifier: "YourChatTableViewCell", for: indexPath) as! YourChatTableViewCell
                    // 이것도 마찬가지.
                    yourCell.contentTV_YCTVC.text = chatDatas_CVC[indexPath.row]
                    yourCell.selectionStyle = .none
                    return yourCell
                    
                }
    }
    
}
