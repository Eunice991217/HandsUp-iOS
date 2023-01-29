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
        self.showAlertController(style: UIAlertController.Style.actionSheet)
        // self.presentingViewController?.view.alpha = 0.2
    }
    
    func showAlertController(style: UIAlertController.Style) {
        let alert = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "닫기", style: .cancel) { (action) in };
        
        alert.addAction(cancel)
        
        let Edit = self.storyboard?.instantiateViewController(withIdentifier: "EditProfile")
        let editProfile = UIAlertAction(title: "내 정보 변경", style: UIAlertAction.Style.default,         handler:{(action) in self.navigationController?.pushViewController(Edit!, animated: true)}
        )
        alert.addAction(editProfile)
        
        let Post = self.storyboard?.instantiateViewController(withIdentifier: "MyPost")
        let mypost = UIAlertAction(title: "내 글 관리", style: UIAlertAction.Style.default,         handler:{(action) in self.navigationController?.pushViewController(Post!, animated: true)}
        )
        alert.addAction(mypost)
        
        let tos = self.storyboard?.instantiateViewController(withIdentifier: "ToS")
        let Tos = UIAlertAction(title: "이용약관", style: UIAlertAction.Style.default, handler:{(action) in self.navigationController?.pushViewController(tos!, animated: true)}
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

        editProfile.setValue(UIColor(red: 0.937, green: 0.482, blue: 0.11, alpha: 1), forKey: "titleTextColor")
        cancel.setValue(UIColor(red: 0, green: 0, blue: 0, alpha: 1), forKey: "titleTextColor")
        mypost.setValue(UIColor(red: 0, green: 0, blue: 0, alpha: 1), forKey: "titleTextColor")
        Tos.setValue(UIColor(red: 0, green: 0, blue: 0, alpha: 1), forKey: "titleTextColor")
        accountManagement.setValue(UIColor(red: 0, green: 0, blue: 0, alpha: 1), forKey: "titleTextColor")
        faq.setValue(UIColor(red: 0, green: 0, blue: 0, alpha: 1), forKey: "titleTextColor")
        
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)

        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func HomeSwitchDidTap(_ sender: UISwitch) {
        
        if sender.isOn {
            view.addSubview(ListView)
            view.addSubview(HomeSwitch)
            view.addSubview(HomeTabView)
            view.addSubview(HomeTabBarPlusBtn)
            //view.addSubview(CustomSwitch)
        }
        else {
            view.addSubview(MapView)
            view.addSubview(HomeSwitch)
            view.addSubview(HomeTabView)
            view.addSubview(HomeTabBarPlusBtn)
            //view.addSubview(CustomSwitch)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HomeTabView.clipsToBounds = true
        HomeTabView.layer.cornerRadius = 40
        HomeTabView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
        self.HomeSwitch.isOn = false

        self.navigationController?.navigationBar.isHidden = true;
        // Do any additional setup after loading the view.
    }
    
}

