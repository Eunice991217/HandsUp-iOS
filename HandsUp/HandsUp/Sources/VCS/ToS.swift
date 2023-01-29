//
//  ToS.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/12.
//

import UIKit

class ToS: UIViewController {
    
    
    @IBAction func TosBackBtnDidTap(_ sender: Any) {
        let TosBack = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true;
        // Do any additional setup after loading the view.
    }
    
}
