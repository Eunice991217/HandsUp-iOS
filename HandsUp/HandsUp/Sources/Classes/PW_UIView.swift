//
//  PW_UIView.swift
//  HandsUp
//
//  Created by 황재상 on 2023/01/13.
//

import UIKit

class PW_UIView: UIView {
    var PWTextField:UITextField = UITextField()
    
    func set(){
        PWTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor : UIColor(named: "HandsUpGrey")!])
        PWTextField.translatesAutoresizingMaskIntoConstraints = false
        PWTextField.heightAnchor.constraint(equalToConstant: self.frame.height).isActive = true
        PWTextField.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        PWTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        PWTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 16).isActive = true
    }
}
