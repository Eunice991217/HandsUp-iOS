//
//  ViewController.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/05.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var HomeSwitch: UISwitch!
    @IBOutlet weak var HomeTabBarPlusBtn: UIButton!
    
    @IBOutlet weak var MapView: UIView!
    @IBOutlet weak var ListView: UIView!
    
    @IBOutlet weak var HomeTabView: UIView!
    @IBOutlet weak var HomeSettingBtn: UIButton!
    
    @IBOutlet weak var HomeDidBtn: UIButton!
    @IBOutlet weak var NotificationBtn: UIButton!
    
    var bRec:Bool = true

    @IBAction func HomeBtnDidTap(_ sender: Any) {
        bRec = !bRec
        if bRec {
            HomeDidBtn.setImage(UIImage(named: "HomeIconDidTap"), for: .normal)
            NotificationBtn.setImage(UIImage(named: "notifications"), for: .normal)
        } else {
            HomeDidBtn.setImage(UIImage(named: "HomeIcon"), for: .normal)
        }
    }
    
    @IBAction func NotificationBtnDidTap(_ sender: Any) {
        bRec = !bRec
        if bRec {
            NotificationBtn.setImage(UIImage(named: "notifications"), for: .normal)
            
        } else {
            NotificationBtn.setImage(UIImage(named: "notificationsDidTap"), for: .normal)
            HomeDidBtn.setImage(UIImage(named: "HomeIcon"), for: .normal)
        }
        
    }
    
    
    @IBAction func HomeSettingDidTap(_ sender: Any) {
        let alert = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "닫기", style: .cancel) { (action) in };
        
        alert.addAction(cancel)
        
        let editProfile = UIAlertAction(title: "내 정보 변경", style: .default) { (action) in };
        
        alert.addAction(editProfile)
        
        let mypost = UIAlertAction(title: "내 글 관리", style: .default) { (action) in };
        
        alert.addAction(mypost)
        
        let Tos = UIAlertAction(title: "이용약관", style: .default) { (action) in };
        
        alert.addAction(Tos)
        
        let accountManagement = UIAlertAction(title: "계정관리", style: .default) { (action) in };
        
        alert.addAction(accountManagement)
        
        let report = UIAlertAction(title: "문의하기", style: .default) { (action) in };
        
        alert.addAction(report)

        editProfile.setValue(UIColor(red: 0.937, green: 0.482, blue: 0.11, alpha: 1), forKey: "titleTextColor")
        cancel.setValue(UIColor(red: 0, green: 0, blue: 0, alpha: 1), forKey: "titleTextColor")
        mypost.setValue(UIColor(red: 0, green: 0, blue: 0, alpha: 1), forKey: "titleTextColor")
        Tos.setValue(UIColor(red: 0, green: 0, blue: 0, alpha: 1), forKey: "titleTextColor")
        accountManagement.setValue(UIColor(red: 0, green: 0, blue: 0, alpha: 1), forKey: "titleTextColor")
        report.setValue(UIColor(red: 0, green: 0, blue: 0, alpha: 1), forKey: "titleTextColor")
        
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)

        present(alert, animated: true, completion: nil)
        
    }
    
    //MapView, ListView
    
    @IBAction func HomeSwitchDidTap(_ sender: UISwitch) {
        
        if sender.isOn {
            view.addSubview(ListView)
            view.addSubview(HomeSwitch)
            view.addSubview(HomeTabView)
            view.addSubview(HomeTabBarPlusBtn)
        }
        else {
            view.addSubview(MapView)
            view.addSubview(HomeSwitch)
            view.addSubview(HomeTabView)
            view.addSubview(HomeTabBarPlusBtn)
        }

    }
    
    @IBAction func HomePlusBtnDidTap(_ sender: Any) {
        
        // 스토리보드의 파일 찾기
                let storyboard: UIStoryboard? = UIStoryboard(name: "HandsUp", bundle: Bundle.main)
                
                // 스토리보드에서 지정해준 ViewController의 ID
                guard let registerPostVC = storyboard?.instantiateViewController(identifier: "RegisterPostViewController") else {
                    return
                }
                
        
                // 화면 전환!
                self.present(registerPostVC, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        HomeTabView.clipsToBounds = true
        HomeTabView.layer.cornerRadius = 40
        HomeTabView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
        self.HomeSwitch.isOn = false
        // Do any additional setup after loading the view.
    }
    
}

