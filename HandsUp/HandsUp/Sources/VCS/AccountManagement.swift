//
//  AccountManagement.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/13.
//

import UIKit

class AccountManagement: UIViewController {
    
    @IBAction func AMLogoutDidTap(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "아니요", style: .cancel) { (action) in }; alert.addAction(cancel)
        let confirm = UIAlertAction(title: "네", style: .default) { (action) in }; alert.addAction(confirm)

        confirm.setValue(UIColor(red: 0.608, green: 0.608, blue: 0.608, alpha: 1), forKey: "titleTextColor") //확인버튼 색깔입히기
        cancel.setValue(UIColor(red: 0.957, green: 0.486, blue: 0.086, alpha: 1), forKey: "titleTextColor") //취소버튼 색깔입히기
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        let attributedString = NSAttributedString(string: "로그아웃 하실건가요?", attributes: [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1)])
        alert.setValue(attributedString, forKey: "attributedTitle") //컨트롤러에 설정한 걸 세팅

        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func AMDeleteDidTap(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "아니요", style: .cancel) { (action) in }; alert.addAction(cancel)
        let confirm = UIAlertAction(title: "네", style: .default) { (action) in }; alert.addAction(confirm)

        confirm.setValue(UIColor(red: 0.608, green: 0.608, blue: 0.608, alpha: 1), forKey: "titleTextColor") //확인버튼 색깔입히기
        cancel.setValue(UIColor(red: 0.957, green: 0.486, blue: 0.086, alpha: 1), forKey: "titleTextColor") //취소버튼 색깔입히기
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        let attributedString = NSAttributedString(string: "정말 탈퇴하실건가요..?", attributes: [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1)])
        alert.setValue(attributedString, forKey: "attributedTitle") //컨트롤러에 설정한 걸 세팅

        present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
