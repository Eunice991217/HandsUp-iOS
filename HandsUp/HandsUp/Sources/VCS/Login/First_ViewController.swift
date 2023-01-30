//
//  First_ViewController.swift
//  HandsUp
//
//  Created by 황재상 on 2023/01/31.
//

import UIKit

class First_ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "login") {
        //자동 로그인
            if ServerAPI.login(email: UserDefaults.standard.string(forKey: "email") ?? "", pw: UserDefaults.standard.string(forKey: "password") ?? "") == 1{
            }else{
                UserDefaults.standard.set(false, forKey: "login")
                let loginVC_First = self.storyboard?.instantiateViewController(withIdentifier: "Login")
                self.present(loginVC_First!, animated: false)
            }
        }
        else{
            let loginVC_First = self.storyboard?.instantiateViewController(withIdentifier: "Login")
            self.present(loginVC_First!, animated: false)
        }
    }
}
