//
//  MyProfile.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/31.
//

import UIKit

class MyProfile: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var MyProfileCollectionView: UICollectionView!
    
    @IBOutlet var MyProfileHeartBtn: UIButton!
    
    var bRec:Bool = true
    
    @IBAction func HeartBtnDidTap(_ sender: Any) {
        
        let stat = HomeServerAPI.boardsHeart(boardIdx: 1)
        switch stat {
        case 2000:
            print ("하트 요청에 성공하였습니다.")
        case 4000:
            print ("하트 요청 존재하지 않는 이메일입니다.")
        case 4010:
            print ("하트 요청 게시물 인덱스가 존재하지 않습니다.")
        default:
            print ("하트 요청 데이터베이스 저장 오류가 발생했습니다.")
        }
        
        bRec = !bRec
        if bRec { // 비어진 하트
            MyProfileHeartBtn.setImage(UIImage(named: "HeartSmall"), for: .normal)
        } else { // 버튼 눌렀을때 채워진 하트
            MyProfileHeartBtn.setImage(UIImage(named: "HeartDidTap"), for: .normal)
        }
    }
    
    @IBAction func MyProfilemoreDidTap(_ sender: Any) {
        self.showAlertController(style: UIAlertController.Style.actionSheet)
    }
    
    func showAlertController(style: UIAlertController.Style) {
        let alert = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "닫기", style: .cancel) { (action) in };
        alert.addAction(cancel)
        
        let block = UIAlertAction(title: "이 게시물 그만보기", style: UIAlertAction.Style.default, handler:{(action) in self.showBlockAlert()}
        )
        alert.addAction(block)
        
        let Report = self.storyboard?.instantiateViewController(withIdentifier: "Report")
        let report = UIAlertAction(title: "신고하기",style: UIAlertAction.Style.default, handler:{(action) in
            
            Report?.modalPresentationStyle = .fullScreen
            // 화면 전환!

            let transition = CATransition()
            transition.duration = 0.3
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            self.view.window!.layer.add(transition, forKey: kCATransition)

            self.present(Report!, animated: false)
        }
        )
        alert.addAction(report)
    
        
        cancel.setValue(UIColor(red: 0, green: 0, blue: 0, alpha: 1), forKey: "titleTextColor")
        report.setValue(UIColor(red: 0.31, green: 0.494, blue: 0.753, alpha: 1), forKey: "titleTextColor")
        block.setValue(UIColor(red: 0, green: 0, blue: 0, alpha: 1), forKey: "titleTextColor")
        
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
        let attributedString = NSAttributedString(string: "해당 게시물을 차단하면 이 게시물은 더이상 볼 수 없습니다.", attributes: [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1)])
        alert.setValue(attributedString, forKey: "attributedTitle") //컨트롤러에 설정한 걸 세팅

        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func MyProfileChatBtnDidTap(_ sender: Any) {
        
        // ChatViewController
        let storyboard: UIStoryboard? = UIStoryboard(name: "HandsUp", bundle: Bundle.main)
        
        guard let nextVC = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController else { return  }
        
        nextVC.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        
    
        present(nextVC, animated: false, completion: nil)
    }
    
    @IBAction func MyProfileDismissBtnDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MyProfileData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProfileCollectionViewCell", for: indexPath) as! MyProfileCollectionViewCell
        
        cell.MyProfileCellImage.image=MyProfileData[indexPath.row].profileImage
        cell.MyProfileSmallName.text=MyProfileData[indexPath.row].name
        cell.MyProfileCellLargeName.text=MyProfileData[indexPath.row].name
        cell.MyProfileCellLocation.text=MyProfileData[indexPath.row].location
        cell.MyProfileCellTime.text=MyProfileData[indexPath.row].time
        cell.MyProfileCellContent.text=MyProfileData[indexPath.row].content
        
        cell.MyProfileCellTag.text = MyProfileData[indexPath.row].tag
        cell.MyProfileCellTag.font = UIFont(name: "Roboto-Bold", size: 14)
        
        cell.MyProfileTag.cornerRadius = 12
        
        cell.MyProfileCellUniv.text = MyProfileData[indexPath.row].univ
        cell.MyProfileCellUniv.font = UIFont(name: "Roboto-Bold", size: 14)
        
        cell.MyProfileUniv.cornerRadius = 12
        
        cell.MyProfileCellContent.sizeToFit()
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        MyProfileCollectionView.backgroundColor = .none
        
        self.navigationController?.isNavigationBarHidden = true
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0 // cell사이의 간격 설정
        
        MyProfileCollectionView.collectionViewLayout = flowLayout
        
        MyProfileCollectionView.delegate = self
        MyProfileCollectionView.dataSource = self
        
    }
    
    
}

extension MyProfile: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

struct MyProfileDataModel {
    let profileImage: UIImage?
    let name: String
    let location: String
    let time: String
    let content: String
    let tag: String
    let univ: String
}

let MyProfileData: [MyProfileDataModel] = [
    MyProfileDataModel(
        profileImage: UIImage(named: "characterExample4"),
        name: "차라나",
        location: "경기도 성남시",
        time: "10분전",
        content: "제가 3시쯤 수업이 끝날거 같은데 3시 30에 학교근처에서 토익 스터디 하실분 계신가요? 공부 끝나고 커피 한잔 같이 하실분 구해요~! \n \n연락주세요😎",
        tag: "#스터디",
        univ: "세종대"
    ),
    MyProfileDataModel(
        profileImage: UIImage(named: "characterExample4"),
        name: "카리나",
        location: "경기도 성남시",
        time: "40분전",
        content: "제가 5시쯤 수업이 끝날거 같은데 6시 30에 학교근처에서 노래방 가실분 계신가요? \n \n연락주세요💚",
        tag: "#취미",
        univ: "세종대"
    ),
    MyProfileDataModel(
        profileImage: UIImage(named: "characterExample4"),
        name: "오나라",
        location: "경기도 성남시",
        time: "15분전",
        content: "제가 2시쯤 수업이 끝날거 같은데 2시 30에 학교근처에서 잔치국수 먹으실분 계신가요? 잔치국수 먹고 커피 한잔 같이 하실분 구해요~! \n \n연락주세요😁",
        tag: "#밥",
        univ: "세종대"
    )
]
