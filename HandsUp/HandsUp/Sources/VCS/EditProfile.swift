//
//  EditProfile.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/13.
//

import UIKit

class EditProfile: UIViewController {
    
    
    @IBOutlet weak var EditProfileBtn: UIView!
    @IBOutlet weak var EditProfileLabel: UILabel!
    @IBOutlet weak var EditProfileView: UIView!
    @IBOutlet weak var EditProfileSend: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EditProfileBtn.layer.cornerRadius=10
        EditProfileView.layer.cornerRadius=115
        EditProfileSend.layer.cornerRadius=10
        // Do any additional setup after loading the view.
    }

}
