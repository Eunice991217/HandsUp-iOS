//
//  postThroughChatViewController.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/01/26.
//

import UIKit

class PostThroughChatViewController: UIViewController {

    var boardIdx: Int64 = 0
    var postAuthorNickName: String = ""
    let currentUserNickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
    var singleBoard: board_in_chat_result?
    var boardsCharacterList: [Int] = []
    @IBOutlet var tagLabel_PTCVC: UILabel!
    @IBOutlet var schoolLabel_PTCVC: UILabel!
    @IBOutlet var nameLabel_PTCVC: UILabel!
    @IBOutlet var smallNameLabel_PTCVC: UILabel!
    @IBOutlet var locationLabel_PTCVC: UILabel!
    @IBOutlet var timeLabel_PTCVC: UILabel!
    
    var beforeVC: ChatViewController?
    @IBOutlet weak var contentTextView_PTCVC: UITextView!
    
    @IBOutlet weak var characterView_PTCVC: Character_UIView!
    
    @IBOutlet var tagLabelXConstraint_PTCVC: NSLayoutConstraint!
    
    lazy var blurredView: UIView = {
            // 1. create container view
            let containerView = UIView()
            // 2. create custom blur view
            let blurEffect = UIBlurEffect(style: .light)
            let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.2)
            customBlurEffectView.frame = self.view.bounds
            // 3. create semi-transparent black view
            let dimmedView = UIView()
            dimmedView.backgroundColor = .white.withAlphaComponent(0.1)
            dimmedView.frame = self.view.bounds
            
            // 4. add both as subviews
            containerView.addSubview(customBlurEffectView)
            containerView.addSubview(dimmedView)
            return containerView
        
        
        }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        singleBoard = PostAPI.getBoardInChat(boardIdx: boardIdx)?.result
        postAuthorNickName = singleBoard?.nickname ?? ""
        self.navigationController?.isNavigationBarHidden = true

        self.view.backgroundColor = UIColor(red: 0.642, green: 0.642, blue: 0.642, alpha: 0.8)
        contentTextView_PTCVC.textContainerInset = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        contentTextView_PTCVC.isEditable = false
        
        setupView()
       // self.tagLabel_PTCVC.text = singleBoard?.board.tag
        self.nameLabel_PTCVC.text = singleBoard?.nickname
        self.smallNameLabel_PTCVC.text = singleBoard?.nickname
        // self.locationLabel_PTCVC.text = singleBoard. 위치 정보
        self.contentTextView_PTCVC.text = singleBoard?.board.content
        self.timeLabel_PTCVC.text = formatDatetoString(singleBoard?.board.createdAt ?? "")
        self.tagLabel_PTCVC.text = "# " + (singleBoard?.tag ?? "")
        self.schoolLabel_PTCVC.text = singleBoard?.schoolName ?? ""
        
        
        boardsCharacterList = []
        
        let background = (Int(singleBoard!.character.backGroundColor) ?? 1) - 1
        let hair = (Int(singleBoard!.character.hair) ?? 1) - 1
        let eyebrow = (Int(singleBoard!.character.eyeBrow) ?? 1) - 1
        let mouth = (Int(singleBoard!.character.mouth) ?? 1) - 1
        let nose = (Int(singleBoard!.character.nose) ?? 1) - 1
        let eyes = (Int(singleBoard!.character.eye) ?? 1) - 1
        let glasses = Int(singleBoard!.character.glasses) ?? 0
        
        boardsCharacterList.append(background)
        boardsCharacterList.append(hair)
        boardsCharacterList.append(eyebrow)
        boardsCharacterList.append(mouth)
        boardsCharacterList.append(nose)
        boardsCharacterList.append(eyes)
        boardsCharacterList.append(glasses)
        
        characterView_PTCVC.setAll(componentArray: boardsCharacterList) // 가져오기
        characterView_PTCVC.setCharacter_NoShadow() // 그림자 없애기
        characterView_PTCVC.setCharacter() // 캐릭터 생성
        
        let screenWidth = UIScreen.main.bounds.size.width
        
        tagLabelXConstraint_PTCVC.constant = screenWidth / 2 - 74
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshBoard()
    }
    func refreshBoard(){
        singleBoard = PostAPI.getBoardInChat(boardIdx: boardIdx)?.result
        
        self.contentTextView_PTCVC.text = singleBoard?.board.content
        self.timeLabel_PTCVC.text = formatDatetoString(singleBoard?.board.createdAt ?? "")
        self.tagLabel_PTCVC.text = "# " + (singleBoard?.tag ?? "")
    }
    
    
    func setupView() {
           // 6. add blur view and send it to back
           view.addSubview(blurredView)
           view.sendSubviewToBack(blurredView)
       }
    
    
    @IBAction func cancelBtnDidTap(_ sender: Any) {
        self.dismiss(animated: false, completion: {
            self.beforeVC?.refreshBoard()
        })
        
    }
    
    
    @IBAction func moreBtnDidTap(_ sender: Any) {
        let isMyPost = currentUserNickname == postAuthorNickName
        
        self.showAlertController(style: .actionSheet, isMyPost: isMyPost)
    }
    
    func showAlertController(style: UIAlertController.Style, isMyPost: Bool) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "닫기", style: .cancel) { (action) in }
        alert.addAction(cancel)
                
        if isMyPost {
            let delete = UIAlertAction(title: "삭제하기", style: .destructive) { (action) in
                PostAPI.deletePost(boardIdx: Int(self.boardIdx))
            }
            alert.addAction(delete)
            
            
            let edit = UIAlertAction(title: "수정하기", style: .default) { (action) in
                // 수정 기능 실행
                
                let myTabVC = UIStoryboard.init(name: "HandsUp", bundle: nil)
                guard let nextVC = myTabVC.instantiateViewController(identifier: "RegisterPostViewController") as? RegisterPostViewController else {
                    return
                }
                nextVC.isEdited = true;
              
                nextVC.boardIdx = Int(self.boardIdx)
                
                self.present(nextVC, animated: true, completion: nil)
            }
            alert.addAction(edit)
            
            let titleTextColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cancel.setValue(titleTextColor, forKey: "titleTextColor")
            
            edit.setValue(UIColor(red: 0.31, green: 0.494, blue: 0.753, alpha: 1), forKey: "titleTextColor")
            delete.setValue(titleTextColor, forKey: "titleTextColor")
            
        } else {
            let block = UIAlertAction(title: "이 게시물 그만보기", style: .default) { (action) in
                
                self.showBlockAlert()
            }
            alert.addAction(block)
            let storyboard_main: UIStoryboard? = UIStoryboard(name: "Main", bundle: Bundle.main)
            let Report = storyboard_main?.instantiateViewController(withIdentifier: "Report")
                
            let report = UIAlertAction(title: "신고하기", style: .default) { (action) in
                Report?.modalPresentationStyle = .fullScreen
                // 화면 전환!
            
                let transition = CATransition()
                transition.duration = 0.3
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                self.view.window!.layer.add(transition, forKey: kCATransition)
                
                self.present(Report!, animated: false)
            }
            alert.addAction(report)
            
            // 버튼 색상 설정
            let titleTextColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cancel.setValue(titleTextColor, forKey: "titleTextColor")
            
            report.setValue(UIColor(red: 0.31, green: 0.494, blue: 0.753, alpha: 1), forKey: "titleTextColor")
            block.setValue(titleTextColor, forKey: "titleTextColor")
        }
        
        // 버튼 색상 설정
        let titleTextColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        cancel.setValue(titleTextColor, forKey: "titleTextColor")
        
        
        // 배경색 설정
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
        
        present(alert, animated: true, completion: nil)
    }

    
    func showBlockAlert(){
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "아니요", style: .cancel) { (action) in }; alert.addAction(cancel)
        let confirm = UIAlertAction(title: "네", style: .default) { (action) in
            let blockResponse = ServerAPI.boardsBlock(boardIdx: Int(self.boardIdx)).statusCode
        }; alert.addAction(confirm)

        confirm.setValue(UIColor(red: 0.563, green: 0.691, blue: 0.883, alpha: 1), forKey: "titleTextColor") //확인버튼 색깔입히기
        cancel.setValue(UIColor(red: 0.663, green: 0.663, blue: 0.663, alpha: 1), forKey: "titleTextColor") //취소버튼 색깔입히기
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        let attributedString = NSAttributedString(string: "해당 게시물을 차단하면 이 게시물은 더이상 볼 수 없습니다.", attributes: [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1)])
        alert.setValue(attributedString, forKey: "attributedTitle") //컨트롤러에 설정한 걸 세팅

        present(alert, animated: true, completion: nil)
    }
    
    
    

}
