import UIKit
import SwiftUI

class MyProfileView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var MyProfileCollectionView: UICollectionView!
    
    var HomeCardList : [boardsShowList_rp_getBoardList] = []
    var boardsCharacterList: [Int] = []
    var background = 0, hair = 0, eyebrow = 0, mouth = 0, nose = 0, eyes = 0, glasses = 0
    var selectedIndexPath: IndexPath?
    
    var boardIndex: Int64?
    var bRec:Bool = false
    var collectionViewIndexPath = 0;
    
    var isMyPost:Bool = false;
    
    var beforeVC: ListVC?
    
    @IBAction func heartBtnDidTap(_ sender: UIButton) {
        
        let currentUserNickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
        
        let postAuthorNickname = HomeCardList[Int(MyProfileCollectionView.contentOffset.x / (UIScreen.main.bounds.width))].nickname
        
        print(Int(MyProfileCollectionView.contentOffset.x))
        
        print(Int(MyProfileCollectionView.contentOffset.x / (UIScreen.main.bounds.width)))
        
        isMyPost = currentUserNickname == postAuthorNickname
    
        if(isMyPost==false) {
            
            sender.isSelected.toggle() // 버튼 상태를 토글
            
            boardIndex = Int64(HomeCardList[Int(MyProfileCollectionView.contentOffset.x / (UIScreen.main.bounds.width))].board.boardIdx)

            
            if sender.isSelected {
                sender.setImage(UIImage(named: "heartTap"), for: .normal)
                let stat = HomeServerAPI.boardsHeart(boardIdx: boardIndex ?? 0)
                print("하트 클릭")
                print("stat : \(stat)")
                
            } else {
                sender.setImage(UIImage(named: "heartOff"), for: .normal)
                print("하트 취소")
            }
        }
        else {
            showBlockAlertMyHeart()
        }
    }
    
    
    @IBAction func myProfileMoreDidTap(_ sender: Any) {
        
        let currentUserNickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
        
        let postAuthorNickname = HomeCardList[Int(MyProfileCollectionView.contentOffset.x / (UIScreen.main.bounds.width))].nickname
        
        isMyPost = currentUserNickname == postAuthorNickname
        
        print("isMyPost : \(isMyPost)")
        
        self.showAlertController(style: .actionSheet, isMyPost: isMyPost)
    }
    
    func showAlertController(style: UIAlertController.Style, isMyPost: Bool) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "닫기", style: .cancel) { (action) in }
        alert.addAction(cancel)
        
        let Report = self.storyboard?.instantiateViewController(withIdentifier: "Report")
        
        if isMyPost {
            let delete = UIAlertAction(title: "삭제하기", style: .destructive) { (action) in
                PostAPI.deletePost(boardIdx: self.HomeCardList[Int(self.MyProfileCollectionView.contentOffset.x / (UIScreen.main.bounds.width))].board.boardIdx)
            }
            alert.addAction(delete)
            
            
            let edit = UIAlertAction(title: "수정하기", style: .default) { (action) in
                // 수정 기능 실행
                
                let myTabVC = UIStoryboard.init(name: "HandsUp", bundle: nil)
                guard let nextVC = myTabVC.instantiateViewController(identifier: "RegisterPostViewController") as? RegisterPostViewController else {
                    return
                }
                nextVC.isEdited = true;
                //                self.boardIndex = Int64(self.MyProfileCollectionView.contentOffset.x / UIScreen.main.bounds.width)
                //
                nextVC.boardIdx = self.HomeCardList[Int(self.MyProfileCollectionView.contentOffset.x / (UIScreen.main.bounds.width))].board.boardIdx
                
                nextVC.cardVC = self
                self.boardIndex = Int64(self.HomeCardList[Int(self.MyProfileCollectionView.contentOffset.x / (UIScreen.main.bounds.width))].board.boardIdx)
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
            ServerAPI.boardsBlock(boardIdx: self.HomeCardList[Int(self.MyProfileCollectionView.contentOffset.x / (UIScreen.main.bounds.width))].board.boardIdx)
        }
        alert.addAction(confirm)
        
        confirm.setValue(UIColor(red: 0.563, green: 0.691, blue: 0.883, alpha: 1), forKey: "titleTextColor") //확인버튼 색깔입히기
        cancel.setValue(UIColor(red: 0.663, green: 0.663, blue: 0.663, alpha: 1), forKey: "titleTextColor") //취소버튼 색깔입히기
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        let attributedString = NSAttributedString(string: "해당 게시물을 차단하면 이 게시물은 더이상 볼 수 없습니다.", attributes: [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1)])
        alert.setValue(attributedString, forKey: "attributedTitle") //컨트롤러에 설정한 걸 세팅
        
        present(alert, animated: true, completion: nil)
    }
    
    func showBlockAlertMyCard(){
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .default) { (action) in }; alert.addAction(confirm)
        
        confirm.setValue(UIColor(red: 0.563, green: 0.691, blue: 0.883, alpha: 1), forKey: "titleTextColor") //확인버튼 색깔입히기
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        let attributedString = NSAttributedString(string: "본인 게시물은\n채팅을 보낼 수 없습니다.", attributes: [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1)])
        alert.setValue(attributedString, forKey: "attributedTitle") //컨트롤러에 설정한 걸 세팅
        
        present(alert, animated: true, completion: nil)
    }
    
    func showBlockAlertMyHeart(){
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .default) { (action) in }; alert.addAction(confirm)
        
        confirm.setValue(UIColor(red: 0.563, green: 0.691, blue: 0.883, alpha: 1), forKey: "titleTextColor") //확인버튼 색깔입히기
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        let attributedString = NSAttributedString(string: "본인 게시물은\n하트를 보낼 수 없습니다.", attributes: [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1)])
        alert.setValue(attributedString, forKey: "attributedTitle") //컨트롤러에 설정한 걸 세팅
        
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func dismissBtnDidTap(_ sender: Any) {
        self.dismiss(animated: true){
            self.beforeVC?.refresh()
        }
    }
    
    
    @IBAction func chatBtnDidTap(_ sender: Any) {
        
        let currentUserNickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
        
        let postAuthorNickname = HomeCardList[Int(MyProfileCollectionView.contentOffset.x / (UIScreen.main.bounds.width))].nickname
        isMyPost = currentUserNickname == postAuthorNickname
    
        if(isMyPost==false) {
            let storyboard: UIStoryboard? = UIStoryboard(name: "HandsUp", bundle: Bundle.main)
            
            guard let nextVC = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController else { return  }
            //        nextVC.boardIdx = Int(boardIndex!)
            nextVC.boardIdx = Int64(self.HomeCardList[Int(self.MyProfileCollectionView.contentOffset.x / (UIScreen.main.bounds.width))].board.boardIdx)
            nextVC.chatPersonName = HomeCardList[Int(MyProfileCollectionView.contentOffset.x / (UIScreen.main.bounds.width))].nickname
            nextVC.modalPresentationStyle = .fullScreen
            
            let transition = CATransition()
            transition.duration = 0.3
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            view.window!.layer.add(transition, forKey: kCATransition)
            
            
            present(nextVC, animated: false, completion: nil)
            
        }
        
        else {
            showBlockAlertMyCard()
        }
      
        
        
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        selectedIndexPath = indexPath
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("viewDidAppear Collection View 성공 및 원소 개수 == \(HomeCardList.count)")
        return HomeCardList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProfileCollectionViewCell", for: indexPath) as! MyProfileCollectionViewCell
        
        boardsCharacterList = [] // 빈 배열
        
        let characterBoards = HomeCardList[indexPath.row].character
        
        background = (Int(characterBoards.backGroundColor) ?? 1) - 1
        hair = (Int(characterBoards.hair) ?? 1) - 1
        eyebrow = (Int(characterBoards.eyeBrow) ?? 1) - 1
        mouth = (Int(characterBoards.mouth) ?? 1) - 1
        nose = (Int(characterBoards.nose) ?? 1) - 1
        eyes = (Int(characterBoards.eye) ?? 1) - 1
        glasses = Int(characterBoards.glasses) ?? 0
        
        boardsCharacterList.append(background)
        boardsCharacterList.append(hair)
        boardsCharacterList.append(eyebrow)
        boardsCharacterList.append(mouth)
        boardsCharacterList.append(nose)
        boardsCharacterList.append(eyes)
        boardsCharacterList.append(glasses)
        
        cell.profileImage.setAll(componentArray: boardsCharacterList) // 가져오기
        cell.profileImage.setCharacter_NoShadow() // 그림자 없애기
        cell.profileImage.setCharacter() // 캐릭터 생성
        
        cell.smallName.text=HomeCardList[indexPath.row].nickname
        cell.largeName.text=HomeCardList[indexPath.row].nickname
        
        
        let createDate = HomeCardList[indexPath.row].board.createdAt.toDate()
        cell.time.text = formatDateString(HomeCardList[indexPath.row].board.createdAt)
        cell.content.text=HomeCardList[indexPath.row].board.content
        cell.content.sizeToFit()
        
        cell.tagType.text = "#" + HomeCardList[indexPath.row].tag
        cell.tagType.font = UIFont(name: "Roboto-Bold", size: 14)
        
        
        let schoolName = HomeCardList[indexPath.row].schoolName
        var cutSchoolName: String = ""
        
        if(schoolName.count == 6) {
            _ = schoolName.index(schoolName.startIndex, offsetBy: 0)
            let endIndex = schoolName.index(schoolName.startIndex, offsetBy: 3)
            let range = ...endIndex
            
            cutSchoolName = String(schoolName[range])
        }
        else if(schoolName.count == 5) {
            _ = schoolName.index(schoolName.startIndex, offsetBy: 0)
            let endIndex = schoolName.index(schoolName.startIndex, offsetBy: 2)
            let range = ...endIndex
            
            cutSchoolName = String(schoolName[range])
        }
        
        cell.school.text = cutSchoolName
        cell.school.font = UIFont(name: "Roboto-Bold", size: 14)
        
        if(HomeCardList[indexPath.row].didLike=="true") {
            cell.heart.setImage(UIImage(named: "heartTap"), for: .normal)
        }
        else if(HomeCardList[indexPath.row].didLike=="false") {
            cell.heart.setImage(UIImage(named: "heartOff"), for: .normal)
        }
        
        if HomeCardList[indexPath.row].board.indicateLocation == "true" {
            cell.location.text = HomeCardList[indexPath.row].board.location
        } else {
            cell.location.text = "위치 비밀"
        }
        
        return cell
    }
    
    
    
   
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if boardIndex == nil {
            return
        }
        
        var i: Int = 0
        while i < HomeCardList.count{
            if Int(boardIndex!) == HomeCardList[i].board.boardIdx{
                break
            }
            i += 1
        }
        
        self.MyProfileCollectionView.setContentOffset(CGPoint(x: Int(i) * Int(UIScreen.main.bounds.width), y: 0), animated: true)
//        self.MyProfileCollectionView.setContentOffset(CGPoint(x: Int(i) * Int(UIScreen.main.bounds.width * 0.93), y: 0), animated: true)
        
    }
    
    func refresh(){
        HomeCardList = HomeServerAPI.boardsShowList() ?? []
        MyProfileCollectionView.reloadData()
        self.view.layoutIfNeeded()
    }
    
    func setupView() {
        // 6. add blur view and send it to back
        view.addSubview(blurredView)
        view.sendSubviewToBack(blurredView)
    }
    
    lazy var blurredView: UIView = {
        // 1. create container view
        let containerView = UIView()
        // 2. create custom blur view
        let blurEffect = UIBlurEffect(style: .light)
        let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.4)
        customBlurEffectView.frame = self.view.bounds
        // 3. create semi-transparent black view
        let dimmedView = UIView()
        dimmedView.backgroundColor = .black.withAlphaComponent(0.3)
        dimmedView.frame = self.view.bounds
        
        // 4. add both as subviews
        containerView.addSubview(customBlurEffectView)
        containerView.addSubview(dimmedView)
        return containerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        MyProfileCollectionView.collectionViewLayout = createLayout()

        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0 // cell사이의 간격 설정
        MyProfileCollectionView.collectionViewLayout = flowLayout
        MyProfileCollectionView.backgroundColor = .none
        
        MyProfileCollectionView.delegate = self
        MyProfileCollectionView.dataSource = self
        
        HomeCardList = HomeServerAPI.boardsShowList() ?? []
        print("MyProfile 서버통신 성공 및 원소 개수 ==  \(HomeCardList.count)")
        
        setupView()
    }
}

extension MyProfileView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

enum SectionKind: Int, CaseIterable {
    case continuous, continuousGroupLeadingBoundary, paging, groupPaging, groupPagingCentered, none

    // orthogonalScrollingBehavior 종류
    func orthogonalScrollingBehavior() -> UICollectionLayoutSectionOrthogonalScrollingBehavior {
        switch self {
        case .none:
            return UICollectionLayoutSectionOrthogonalScrollingBehavior.none
        case .continuous:
            return UICollectionLayoutSectionOrthogonalScrollingBehavior.continuous
        case .continuousGroupLeadingBoundary:
            return UICollectionLayoutSectionOrthogonalScrollingBehavior.continuousGroupLeadingBoundary
        case .paging:
            return UICollectionLayoutSectionOrthogonalScrollingBehavior.paging
        case .groupPaging:
            return UICollectionLayoutSectionOrthogonalScrollingBehavior.groupPaging
        case .groupPagingCentered:
            return UICollectionLayoutSectionOrthogonalScrollingBehavior.groupPagingCentered
        }
    }
}

func createLayout() -> UICollectionViewLayout {
    let config = UICollectionViewCompositionalLayoutConfiguration()
    config.interSectionSpacing = 20

    // 매개변수 sectionProvider, configuration
    let layout = UICollectionViewCompositionalLayout(sectionProvider: {
        (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
        guard let sectionKind = SectionKind(rawValue: sectionIndex) else { fatalError("unknown section kind") }

        // 양옆으로 다른 item이 보이게!
        // item의 fractionalWidth는 1.0, group의 fractionalWidth는 0.9정도로 설정하고,
        // item의 contentInsets을 주면 됨
        let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2)

        // group의 width를 .fractionalWidth(0.9)정도로 주면 양옆으로 다른 item 보이도록 (centerPaging)
        let containerGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93),
                                               heightDimension: .fractionalHeight(1.0)),
            subitems: [leadingItem])
        let section = NSCollectionLayoutSection(group: containerGroup)
        // scroll direction 설정
        section.orthogonalScrollingBehavior = .groupPagingCentered

        return section
    }, configuration: config)
//    })
    return layout
}
