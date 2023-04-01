//
//  EditProfileName.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/13.
//

import UIKit

class EditProfileName: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var EditProfileNameTextField: UITextField!
    @IBOutlet weak var EditProfileNameBackBtn: UIButton!
    
    @IBOutlet var EfitProfileNameLabel: UILabel!

    
    @IBAction func EditProfileNameBackBtnDidTap(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func nicknameValidation() -> Bool{
            let nickNameArray_Sign_up = Array((EditProfileNameTextField.text ?? "") as String)
            if(nickNameArray_Sign_up.count < 2 || 5 < nickNameArray_Sign_up.count){
                return false
            }
            let pattern_Sign_up = "^[가-힣]$"
            if let regex_Sign_up = try? NSRegularExpression(pattern: pattern_Sign_up, options: .caseInsensitive) {
                    var index_Sign_up = 0
                    while index_Sign_up < nickNameArray_Sign_up.count {
                        let results_Sign_up = regex_Sign_up.matches(in: String(nickNameArray_Sign_up[index_Sign_up]), options: [], range: NSRange(location: 0, length: 1))
                        if results_Sign_up.count == 0 {
                            return false
                        } else {
                            index_Sign_up += 1
                        }
                    }
                }
            return true
        }
    
    var delegate : SendData?
    
    //self.EfitProfileNameLabel.text = "닉네임 변경 요청성공"
    @IBAction func EditProfileNameBtnDidTap(_ sender: Any) {
        if nicknameValidation() {
            // 닉네임 올바른 경우
            delegate?.send(self, Input: EditProfileNameTextField.text)
            let stat = ServerAPI.nickname(nickname: EditProfileNameTextField.text!)
            
            switch stat {
            case -1:
                ServerError()
            case 2000:
                print("닉네임 변경 요청성공")
            case 5000:
                print("닉네임 변경 DB저장 오류")
            case 4011:
                print("닉네임 변경유저 인덱스 존재 X")
            case 4005:
                print("마지막 닉네임 변경일로부터 7일이 경과하지 않았습니다.")
            default: // 4006
                print("닉네임 변경 디비 저장 오류")
            }
            
            if(stat == 5000) {
                self.EfitProfileNameLabel.text = "중복된 닉네임입니다."
            }
            else if(stat == 4005) {
                self.EfitProfileNameLabel.text = "마지막 닉네임 변경일로부터 7일이 경과하지 않았습니다."
            }
           
            let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
            let confirm = UIAlertAction(title: "확인", style: .default) { (action) in
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            };
            
            alert.addAction(confirm)

            confirm.setValue(UIColor(red: 0.563, green: 0.691, blue: 0.883, alpha: 1), forKey: "titleTextColor")
            alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
            let attributedString = NSAttributedString(string: "닉네임 변경이 완료되었습니다.", attributes: [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1)])
            alert.setValue(attributedString, forKey: "attributedTitle") //컨트롤러에 설정한 걸 세팅

            if(stat == 2000) {
                present(alert, animated: true, completion: nil)
            }
            // 닉네임 서버로 보내줌
        }
        else {
            self.EfitProfileNameLabel.text = "올바르지않은 닉네임 형식입니다. 다시 입력해주세요."
        }
    }
    
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
                }
            }
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.send(self, Input: EditProfileNameTextField.text)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: EditProfileNameTextField)
        
        EditProfileNameTextField.delegate = self
        
        self.EditProfileNameTextField.delegate = self
        
        EditProfileNameTextField.borderStyle = .none
        
        print(UserDefaults.standard.string(forKey: "nickname")!)
        
        self.navigationController?.navigationBar.isHidden = true;

        // Do any additional setup after loading the view.
    }
    
}



