//
//  ViewController.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/05.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    @IBOutlet weak var HomeTabBarPlusBtn: UIButton!
    
    @IBOutlet weak var MapView: UIView!
    @IBOutlet weak var ListView: UIView!
    
    @IBOutlet weak var HomeTabView: UIView!
    @IBOutlet weak var HomeSettingBtn: UIButton!
    
    @IBOutlet weak var HomeDidBtn: UIButton!
    @IBOutlet weak var NotificationBtn: UIButton!
    
    
    @IBOutlet var HomeSchoolName: UILabel!
    
    
    @IBOutlet var redNoti: UIImageView!
    
    @IBOutlet var homeBtnXConstraint: NSLayoutConstraint!
    @IBOutlet var bellBtnXConstraint: NSLayoutConstraint!
    
    let safeAreaView = UIView()
    var bomttomSafeAreaInsets: CGFloat = 0.0
    
    var schoolName = UserDefaults.standard.string(forKey: "schoolName")
    var cutSchoolName: String = ""
    
    var bRec:Bool = true
    
    var tabmanList: TabManListVC?
    var tabmanMap: TabManViewController?

    @IBAction func HomeBtnDidTap(_ sender: Any) {
        bRec = !bRec
        if bRec {
            HomeDidBtn.setImage(UIImage(named: "HomeIconDidTap"), for: .normal)
            NotificationBtn.setImage(UIImage(named: "notifications"), for: .normal)
        } else {
            //HomeDidBtn.setImage(UIImage(named: "HomeIcon"), for: .normal)
        }
    }
    
    
    @IBAction func HomeSettingDidTap(_ sender: Any) {
        self.showAlertController(style: UIAlertController.Style.actionSheet)
        // self.presentingViewController?.view.alpha = 0.2
    }
    
    func showAlertController(style: UIAlertController.Style) {
        let alert = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        
        let Edit = self.storyboard?.instantiateViewController(withIdentifier: "EditProfile") as! EditProfile
        Edit.listVC = self.tabmanList?.viewControllers[self.tabmanList!.curIndex]
        let editProfile = UIAlertAction(title: "내 정보 변경", style: UIAlertAction.Style.default,         handler:{(action) in self.navigationController?.pushViewController(Edit, animated: true)}
        )
        
        alert.addAction(editProfile)
        
        let Post = self.storyboard?.instantiateViewController(withIdentifier: "MyPost")
        let mypost = UIAlertAction(title: "내 글 관리", style: UIAlertAction.Style.default,         handler:{(action) in self.navigationController?.pushViewController(Post!, animated: true)}
        )
        alert.addAction(mypost)
        
        
        let tos = NSURL(string: "https://miniahiru.notion.site/55bb2cb2fd8b4f3db75775c7065977a2")
        let SafariView_Tos: SFSafariViewController = SFSafariViewController(url: tos! as URL)
        
        let Tos = UIAlertAction(title: "이용약관", style: UIAlertAction.Style.default, handler:{(action) in 
            self.present(SafariView_Tos, animated: true, completion: nil)}
        )
        alert.addAction(Tos)
        
        let AM = self.storyboard?.instantiateViewController(withIdentifier: "AccountManagement")
        let accountManagement = UIAlertAction(title: "계정관리",style: UIAlertAction.Style.default,      handler:{(action) in self.navigationController?.pushViewController(AM!, animated: true)}
        )
        alert.addAction(accountManagement)
        
        let FAQ = self.storyboard?.instantiateViewController(withIdentifier: "FAQ")
        let faq = UIAlertAction(title: "문의하기", style: UIAlertAction.Style.default, handler:{(action) in self.navigationController?.pushViewController(FAQ!, animated: true)}
        )
        alert.addAction(faq)
        
        let cancel = UIAlertAction(title: "닫기", style: .cancel) { (action) in };
        alert.addAction(cancel)

        editProfile.setValue(UIColor(red: 0.937, green: 0.482, blue: 0.11, alpha: 1), forKey: "titleTextColor")
        cancel.setValue(UIColor(red: 0, green: 0, blue: 0, alpha: 1), forKey: "titleTextColor")
        mypost.setValue(UIColor(red: 0, green: 0, blue: 0, alpha: 1), forKey: "titleTextColor")
        Tos.setValue(UIColor(red: 0, green: 0, blue: 0, alpha: 1), forKey: "titleTextColor")
        accountManagement.setValue(UIColor(red: 0, green: 0, blue: 0, alpha: 1), forKey: "titleTextColor")
        faq.setValue(UIColor(red: 0, green: 0, blue: 0, alpha: 1), forKey: "titleTextColor")

        present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var CustomSwitchBtn: CustromSwitchHome!
    
    @IBAction func CustomSwitchBtnDidTap(_ sender: Any) {
        
        if (CustomSwitchBtn.isOn==false) {
            ListView.alpha = 1
            MapView.alpha = 0
            CustomSwitchBtn.alpha = 1
        }
        else {
            MapView.alpha = 1
            ListView.alpha = 0
            CustomSwitchBtn.alpha = 1
        }
        
    }
    
    @IBAction func HomePlusBtnDidTap(_ sender: Any) {
        
        // 스토리보드의 파일 찾기
        let storyboard: UIStoryboard? = UIStoryboard(name: "HandsUp", bundle: Bundle.main)
                
        // 스토리보드에서 지정해준 ViewController의 ID
//        guard let registerPostVC = storyboard?.instantiateViewController(identifier: "RegisterPostViewController") else {
//            return
//        }
        guard let registerPostVC = storyboard?.instantiateViewController(identifier: "RegisterPostViewController") as? RegisterPostViewController else {
            return
        }
        // 화면 전환!
        registerPostVC.listVC = self.tabmanList?.viewControllers[self.tabmanList!.curIndex]
        
        self.present(registerPostVC, animated: true)
        
    }
    
    @IBAction func BellBtnDidTap(_ sender: Any) { // 연결하기
        let storyboard: UIStoryboard? = UIStoryboard(name: "HandsUp", bundle: Bundle.main)
        
        // 스토리보드에서 지정해준 ViewController의 ID
        guard let alarmNChatVC = storyboard?.instantiateViewController(identifier: "AlarmListViewController") else {
            return
        }
        
        alarmNChatVC.modalPresentationStyle = .fullScreen
        // 화면 전환!
        self.present(alarmNChatVC, animated: false)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HomeTabView.layer.shadowOpacity = 1
        HomeTabView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        HomeTabView.layer.shadowOffset = CGSize(width: 0, height: -8)
        HomeTabView.layer.shadowRadius = 24
        HomeTabView.layer.masksToBounds = false
        
        HomeTabView.clipsToBounds = false
        HomeTabView.layer.cornerRadius = 40
        HomeTabView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
        configureCustomView()
        self.safeAreaView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.safeAreaView)

        self.safeAreaView.backgroundColor = .white

        NSLayoutConstraint.activate([
            self.safeAreaView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.safeAreaView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.safeAreaView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.safeAreaView.heightAnchor.constraint(equalToConstant: bomttomSafeAreaInsets)
        ])
        
        //tab bar 폰에 따라 유동적인 layout
        let screenWidth = UIScreen.main.bounds.size.width
        
        homeBtnXConstraint.constant = screenWidth * 0.496
        bellBtnXConstraint.constant = screenWidth * 0.165
        
        if(schoolName!.count == 6) {
            _ = schoolName!.index(schoolName!.startIndex, offsetBy: 0)
            let endIndex = schoolName!.index(schoolName!.startIndex, offsetBy: 3)
            let range = ...endIndex

            cutSchoolName = String(schoolName![range])
        }
        else if(schoolName!.count == 5) {
            _ = schoolName!.index(schoolName!.startIndex, offsetBy: 0)
            let endIndex = schoolName!.index(schoolName!.startIndex, offsetBy: 2)
            let range = ...endIndex

            cutSchoolName = String(schoolName![range])
        }
        
         HomeSchoolName.text = cutSchoolName
        
        
        self.navigationController?.navigationBar.isHidden = true;
        // Do any additional setup after loading the view.
        
        tabmanList = self.storyboard?.instantiateViewController(withIdentifier: "TabManList") as? TabManListVC
        tabmanMap = self.storyboard?.instantiateViewController(withIdentifier: "TabManMap") as? TabManViewController
        
        ListView.addSubview(tabmanList!.view)
        MapView.addSubview(tabmanMap!.view)
        
        tabmanList!.view.frame = ListView.bounds
        tabmanMap!.view.frame = MapView.bounds
        
        HomeTabBarPlusBtn.layer.shadowColor = UIColor.black.cgColor // 색깔
        HomeTabBarPlusBtn.layer.masksToBounds = false
        HomeTabBarPlusBtn.layer.shadowOffset = CGSize(width: 0, height: 2) // 위치조정
        HomeTabBarPlusBtn.layer.shadowRadius = 5 // 반경
        HomeTabBarPlusBtn.layer.shadowOpacity = 0.3 // alpha값
        refreshRedBin()
        
    }
    
    override func viewWillAppear(_ animated: Bool){
        refreshRedBin()
    }
    
    func refreshRedBin(){
        if hasNewerChat() || hasNewerChat() {
            redNoti.isHidden = false
        }else{
            redNoti.isHidden = true
        }
    }
    
    func configureCustomView() {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        if let hasWindowScene = windowScene {
            bomttomSafeAreaInsets = hasWindowScene.windows.first?.safeAreaInsets.bottom ?? 0
        }
    }
    
}

