//
//  Report.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/14.
//

import UIKit

class Report: UIViewController {
    
    @IBOutlet weak var ReportTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ReportTextView.delegate = self
        
        //처음 화면이 로드되었을 때 플레이스 홀더처럼 보이게끔 만들어주기
        ReportTextView.text = "신고내용을 자세히 입력해주세요."
        ReportTextView.textColor = UIColor.lightGray
                       
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                       self.ReportTextView.resignFirstResponder()
               }

        // Do any additional setup after loading the view.
    }

}

extension Report: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if ReportTextView.text.isEmpty {
            ReportTextView.text =  "신고내용을 자세히 입력해주세요."
            ReportTextView.textColor = UIColor.lightGray
        }

    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if ReportTextView.textColor == UIColor.lightGray {
            ReportTextView.text = nil
            ReportTextView.textColor = UIColor.black
        }
    }
}
