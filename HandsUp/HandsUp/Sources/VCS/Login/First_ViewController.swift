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
        let status: Int
        ServerAPI.logout()
        if UserDefaults.standard.bool(forKey: "login") {
            status = ServerAPI.login(email: UserDefaults.standard.string(forKey: "email") ?? "", pw: UserDefaults.standard.string(forKey: "pw") ?? "")
        }else{
            status = 0
        }
        if status == 2000{
            let mainSB_First = UIStoryboard(name: "Main", bundle: nil)
            let homeVC_First = mainSB_First.instantiateViewController(withIdentifier: "Home")
            self.navigationController?.pushViewController(homeVC_First, animated: false)
        }
        else if status == -1{
            ServerError()
        }
        else{
            let loginVC_First = self.storyboard?.instantiateViewController(withIdentifier: "Login")
            self.navigationController?.pushViewController(loginVC_First!, animated: false)
        }
    }
}
