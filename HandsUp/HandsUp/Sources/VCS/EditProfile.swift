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
    
    @IBOutlet weak var EditProfileView: Character_UIView!
    
    @IBOutlet weak var EditProfileSend: UIView!
    
    @IBOutlet weak var EditProfileChar: UIButton!
    
    @IBOutlet weak var EditProfileBackBtn: UIButton!
    
    
    @IBAction func EditProfileBackDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func EditProfileNameDidTap(_ sender: Any) {
        let EditName = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileName")
                self.navigationController?.pushViewController(EditName!, animated: true)
    }
    
    @objc func editCharProfile(_ sender: Any){
        print(1)
        let Sign_upSB_Login = UIStoryboard(name: "Sign_up", bundle: nil)
        let sign_upVC_Login = Sign_upSB_Login.instantiateViewController(withIdentifier: "CharacterEdit") as! CharacterEdit_ViewController
        sign_upVC_Login.modalPresentationStyle = .fullScreen
        self.present(sign_upVC_Login, animated: true)
    }
    
    @objc func charaterHighlightToggle(_ sender: Any){
        EditProfileView.highlightToggle()
    }
    
    
    func buttonInit(){
        EditProfileView.setUserCharacter()
        EditProfileChar.addTarget(self, action: #selector(charaterHighlightToggle(_:)), for: .touchDown)
        EditProfileChar.addTarget(self, action: #selector(charaterHighlightToggle(_:)), for: .touchUpInside)
        EditProfileChar.addTarget(self, action: #selector(charaterHighlightToggle(_:)), for: .touchUpOutside)
        EditProfileChar.addTarget(self, action: #selector(editCharProfile(_:)), for: .touchUpInside)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EditProfileBtn.layer.cornerRadius=10
        EditProfileView.layer.cornerRadius=115
        EditProfileSend.layer.cornerRadius=10
        
        self.navigationController?.navigationBar.isHidden = true;
        
        buttonInit()
        // Do any additional setup after loading the view.
    }

}
