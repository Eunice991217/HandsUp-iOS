//
//  MyProfile.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/31.
//

import UIKit

class MyProfile: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var MyProfileCollectionView: UICollectionView!
    
    
    @IBAction func MyProfilemoreDidTap(_ sender: Any) {
        self.showAlertController(style: UIAlertController.Style.actionSheet)
    }
    
    func showAlertController(style: UIAlertController.Style) {
        let alert = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "닫기", style: .cancel) { (action) in };
        alert.addAction(cancel)
        
        let storyboard_main: UIStoryboard? = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let Report = storyboard_main?.instantiateViewController(identifier: "Report") else { return }
        
        let block = UIAlertAction(title: "이 게시물 그만보기", style: UIAlertAction.Style.default, handler:{(action) in self.showBlockAlert()}
        )
        alert.addAction(block)
        
        let report = UIAlertAction(title: "신고하기",style: UIAlertAction.Style.default, handler:{(action) in
        // 화면 전환!
        self.present(Report, animated: true)
            
        self.navigationController?.pushViewController(Report, animated: true)}
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
        
        guard let chat = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") else {return}
//        let chat = storyboard?.instantiateViewController(withIdentifier: "ChatViewController")
//        self.navigationController?.pushViewController(chat!, animated: true)

        chat.modalPresentationStyle = .fullScreen
        
        self.present(chat, animated: true, completion:nil)
    }
    
    @IBAction func MyProfileDismissBtnDidTap(_ sender: Any) {
//        let backHome = self.storyboard?.instantiateViewController(withIdentifier: "Home")
//        self.navigationController?.pushViewController(backHome!, animated: true)
        
//        guard let backHome = self.storyboard?.instantiateViewController(withIdentifier: "MyProfile") else {return}
//        self.present(backHome, animated: true, completion:nil)
//
//        backHome.modalPresentationStyle = .fullScreen
        
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
        dimmedView.backgroundColor = .white.withAlphaComponent(0.1)
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
        
        cell.MyProfileCellImage.image = MyProfileData[indexPath.row].profileImage
        cell.MyProfileSmallName.text=MyProfileData[indexPath.row].name
        cell.MyProfileCellLargeName.text=MyProfileData[indexPath.row].name
        cell.MyProfileCellLocation.text=MyProfileData[indexPath.row].location
        cell.MyProfileCellTime.text=MyProfileData[indexPath.row].time
        cell.MyProfileCellContent.text=MyProfileData[indexPath.row].content
        cell.MyProfileCellContent.sizeToFit()
        cell.MyProfileCellTag.text=MyProfileData[indexPath.row].tag
        cell.MyProfileCellTag.font = UIFont(name: "Roboto-Bold", size: 14)
        cell.MyProfileTag.cornerRadius = 12
        
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
}

let MyProfileData: [MyProfileDataModel] = [
    MyProfileDataModel(
        profileImage: UIImage(named: "characterExample4"),
        name: "차라나",
        location: "경기도 성남시",
        time: "10분전",
        content: "제가 3시쯤 수업이 끝날거 같은데 3시 30에 학교근처에서 토익 스터디 하실분 계신가요? 공부 끝나고 커피 한잔 같이 하실분 구해요~! \n \n연락주세요😎",
        tag: "#스터디"
    ),
    MyProfileDataModel(
        profileImage: UIImage(named: "characterExample4"),
        name: "카리나",
        location: "경기도 성남시",
        time: "40분전",
        content: "제가 5시쯤 수업이 끝날거 같은데 6시 30에 학교근처에서 노래방 가실분 계신가요? \n \n연락주세요💚",
        tag: "#취미"
    ),
    MyProfileDataModel(
        profileImage: UIImage(named: "characterExample4"),
        name: "오나라",
        location: "경기도 성남시",
        time: "15분전",
        content: "제가 2시쯤 수업이 끝날거 같은데 2시 30에 학교근처에서 잔치국수 먹으실분 계신가요? 잔치국수 먹고 커피 한잔 같이 하실분 구해요~! \n \n연락주세요😁",
        tag: "#밥"
    )
]
