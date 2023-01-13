//
//  ViewController.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/05.
//

import UIKit

class Home: UIViewController {
    
    @IBOutlet weak var HomeTabView: UIView!
    @IBOutlet weak var HomeRestartBtn: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HomeTabView.clipsToBounds = true
        HomeTabView.layer.cornerRadius = 40
        HomeTabView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
        HomeRestartBtn.layer.cornerRadius=13
        // Do any additional setup after loading the view.
    }
    
}

