//
//  Report.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/14.
//

import UIKit

class Report: UIViewController {
    
    @IBOutlet weak var ReportTextView: UITextView!
    @IBOutlet weak var ReportView: UIView!
    @IBOutlet weak var ReportSubmit: UIButton!
    
    
    @IBOutlet weak var ReportBackBtn: UIButton!
    
    
    @IBAction func ReportBackBtnDidTap(_ sender: Any) {
        
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ReportSubmitDidTap(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
//        let confirm = UIAlertAction(title: "확인", style: .default) { (action) in };
        
        let main = self.storyboard?.instantiateViewController(withIdentifier: "ViwController")
        
        // "확인" 버튼이 눌렸을 때 화면 전환 코드
        let confirm = UIAlertAction(title: "확인", style: .default) { (action) in
            // 화면 전환
            if let mainViewController = main {
                self.present(mainViewController, animated: true, completion: nil)
            }
        }
        
        alert.addAction(confirm)

        confirm.setValue(UIColor(red: 0.957, green: 0.486, blue: 0.086, alpha: 1), forKey: "titleTextColor") //확인버튼 색깔입히기
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        
        let attributedString = NSAttributedString(string: "신고가 완료되었습니다. 더욱 쾌적한 핸즈업이 되겠습니다.", attributes: [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1)])
        alert.setValue(attributedString, forKey: "attributedTitle") //컨트롤러에 설정한 걸 세팅

        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ReportTextView.delegate = self
        
        //처음 화면이 로드되었을 때 플레이스 홀더처럼 보이게끔 만들어주기
        ReportTextView.text = "신고내용을 자세히 입력해주세요."
        ReportTextView.textColor = UIColor.lightGray
                       
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                       self.ReportTextView.resignFirstResponder()
               }
        
        ReportView.layer.cornerRadius=20
        
        self.navigationController?.navigationBar.isHidden = true;
        
        self.hideKeyboard()
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
