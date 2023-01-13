//
//  EditProfileName.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/13.
//

import UIKit

class EditProfileName: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var EditProfileNameTextField: UITextField!
    
    func EditProfileNameTextField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = EditProfileNameTextField.text else {return false}
        
        // 최대 글자수 이상을 입력한 이후에는 중간에 다른 글자를 추가할 수 없게끔 작동
        if text.count >= 5 && range.length == 0 && range.location < 5 {
            return false
        }
        
        return true
    }
    
    @objc func textDidChange(_ notification: Notification) {
            if let textField = notification.object as? UITextField {
                if let text = textField.text {
                    
                    if text.count > 5 {
                        // 5글자 넘어가면 자동으로 키보드 내려감
                        EditProfileNameTextField.resignFirstResponder()
                    }
                    
                    // 초과되는 텍스트 제거
                    if text.count >= 5 {
                        let index = text.index(text.startIndex, offsetBy: 5)
                        let newString = text[text.startIndex..<index]
                        textField.text = String(newString)
                    }
                    // 2글자 이하일경우 확인버튼 안눌림
//                    else if text.count < 2 {
//
//                    }
                    // 제대로 입력됐을때만 확인버튼 눌림
//                    else {
//
//                    }
                }
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidChange(_:)),
                                               name: UITextField.textDidChangeNotification,
                                               object: EditProfileNameTextField)
        
        EditProfileNameTextField.delegate = self
        EditProfileNameTextField.borderStyle = .none
        // Do any additional setup after loading the view.
    }
    
}



