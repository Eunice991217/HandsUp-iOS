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
        let confirm = UIAlertAction(title: "네", style: .default) { (action) in
            UserDefaults.standard.set(false, forKey: "login")
            let stat = ServerAPI.logout()
            switch stat {
            case 2000:
                print("로그아웃 요청성공")
                PostAPI.deleteFCMToken()
            case 4011:
                print("로그아웃 유저 인덱스가 존재하지 않음")
            default:
                print("Test")
            }
            
            let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
            let logoutBtnDidTap = storyboard.instantiateViewController(identifier: "First")
            self.navigationController?.pushViewController(logoutBtnDidTap, animated: false)
        };
        
        alert.addAction(confirm)

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
        let confirm = UIAlertAction(title: "네", style: .default) { (action) in
            UserDefaults.standard.set(false, forKey: "login")
            let stat = ServerAPI.withdraw()
            switch stat {
            case 2000:
                print("탈퇴 요청성공")
                PostAPI.deleteFCMToken()
            case 4011:
                print("탈퇴 유저 인덱스가 존재하지 않음")
            case 4017:
                print("이미 탈퇴한 회원")
            default: // 5000
                print("탈퇴 DB저장 오류")
            }
            
            let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
            let withDrawBtnDidTap = storyboard.instantiateViewController(identifier: "First")
            self.navigationController?.pushViewController(withDrawBtnDidTap, animated: false)
        };
        alert.addAction(confirm)

        confirm.setValue(UIColor(red: 0.608, green: 0.608, blue: 0.608, alpha: 1), forKey: "titleTextColor") //확인버튼 색깔입히기
        cancel.setValue(UIColor(red: 0.957, green: 0.486, blue: 0.086, alpha: 1), forKey: "titleTextColor") //취소버튼 색깔입히기
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        let attributedString = NSAttributedString(string: "정말 탈퇴하실건가요..?", attributes: [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1)])
        alert.setValue(attributedString, forKey: "attributedTitle") //컨트롤러에 설정한 걸 세팅

        present(alert, animated: true, completion: nil)
    }

    
    @IBAction func AMBackBtnDidTap(_ sender: Any) {
        let AMBack = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true;

//        self.navigationController?.navigationBar.tintColor = .black
//        self.navigationController?.navigationBar.topItem?.title = ""
        // Do any additional setup after loading the view.
    }

}
