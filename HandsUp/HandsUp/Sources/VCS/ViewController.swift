//
//  ViewController.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/05.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var HomeTabView: UIView!
    @IBOutlet weak var HomeRestartBtn: UIView!
    @IBOutlet weak var HomeSettingBtn: UIButton!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HomeTabView.clipsToBounds = true
        HomeTabView.layer.cornerRadius = 40
        HomeTabView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
        HomeRestartBtn.layer.cornerRadius=13
        // Do any additional setup after loading the view.
    }
    
}

