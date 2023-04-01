//
//  FAQ.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/08.
//

import UIKit

class FAQ: UIViewController {

    @IBOutlet weak var HomeFAQTextField: UIView!
    @IBOutlet weak var HomeFAQTextView: UITextView!
    
    @IBOutlet weak var FAQSubmit: UIButton!
    
    @IBAction func SubmitBtnDidTap(_ sender: Any) {
        let stat = HomeServerAPI.FAQ(contents: HomeFAQTextView.text)
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .default) { (action) in
            switch stat {
            case -1:
                self.ServerError()
            case 2000:
                print("문의사항 요청성공")
            case 4000:
                print("문의사항 존재안하는 이메일")
            default:
                print("문의사항 디비 저장 오류")
            }
            self.navigationController?.popViewController(animated: true)
        };
        
        alert.addAction(confirm)

        confirm.setValue(UIColor(red: 0.563, green: 0.691, blue: 0.883, alpha: 1), forKey: "titleTextColor")
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        let attributedString = NSAttributedString(string: "문의사항 보내기 완료되었습니다.\n감사합니다.", attributes: [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1)])
        alert.setValue(attributedString, forKey: "attributedTitle") //컨트롤러에 설정한 걸 세팅

        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func FAQBackBtnDidTap(_ sender: Any) {
//        let FAQBack = self.storyboard?.instantiateViewController(withIdentifier: "Home")
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HomeFAQTextField.layer.cornerRadius=20
        
        HomeFAQTextView.delegate = self
                
        //처음 화면이 로드되었을 때 플레이스 홀더처럼 보이게끔 만들어주기
        HomeFAQTextView.text = "문의내용을 입력해주세요."
        HomeFAQTextView.textColor = UIColor.lightGray
                
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.HomeFAQTextView.resignFirstResponder()
        }
        
        self.navigationController?.navigationBar.isHidden = true;
        
        self.hideKeyboard()
        // Do any additional setup after loading the view.
    }

}

extension FAQ: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if HomeFAQTextView.text.isEmpty {
            HomeFAQTextView.text =  "문의내용을 입력해주세요."
            HomeFAQTextView.textColor = UIColor.lightGray
        }

    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if HomeFAQTextView.textColor == UIColor.lightGray {
            HomeFAQTextView.text = nil
            HomeFAQTextView.textColor = UIColor.black
        }
    }
}
