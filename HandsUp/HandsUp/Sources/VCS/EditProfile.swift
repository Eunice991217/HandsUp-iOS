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
    
   
    @IBOutlet weak var EditProfileBackBtn: UIButton!
    
    
    @IBAction func EditProfileBackDidTap(_ sender: Any) {
        let editBack = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func EditProfileNameDidTap(_ sender: Any) {
        let EditName = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileName")
                self.navigationController?.pushViewController(EditName!, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EditProfileBtn.layer.cornerRadius=10
        EditProfileView.layer.cornerRadius=115
        EditProfileSend.layer.cornerRadius=10
        
        self.navigationController?.navigationBar.isHidden = true;
        
        // Do any additional setup after loading the view.
    }

}
