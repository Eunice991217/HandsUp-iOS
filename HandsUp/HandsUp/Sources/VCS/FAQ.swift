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
