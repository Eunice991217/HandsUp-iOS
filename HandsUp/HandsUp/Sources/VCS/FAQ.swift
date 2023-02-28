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
        switch stat {
        case -1:
            ServerError()
        case 2000:
            print("문의사항 요청성공")
        case 4000:
            print("문의사항 존재안하는 이메일")
        default:
            print("문의사항 디비 저장 오류")
        }
        self.navigationController?.popViewController(animated: true)
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
