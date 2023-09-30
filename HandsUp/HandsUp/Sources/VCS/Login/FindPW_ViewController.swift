import UIKit

class FindPW_ViewController: UIViewController {
    @IBOutlet weak var emailTextField_FindPW: UITextField!
    @IBOutlet weak var findPWButton_FindPW: RoundedShadow_UIButton!
    var isFindPWEnable_FindPW: Bool  = false
    
    @objc func isIDInput(_sender: Any?){
        if(emailTextField_FindPW.text != ""){
            findPWButton_FindPW.backgroundColor = UIColor(named: "HandsUpOrange")
            self.isFindPWEnable_FindPW = true
            
        }else{
            findPWButton_FindPW.backgroundColor = UIColor(named: "HandsUpWhiteGrey")
            self.isFindPWEnable_FindPW = false
        }
    }
    
    @IBAction func backButtonTap_FindPW(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func findPWBTNTap(_ sender: Any) {
        if !isFindPWEnable_FindPW{
            return
        }
        if false {
            let text: String = "인증번호가 발송되었습니다"
            let attributeString = NSMutableAttributedString(string: text)
            let font = UIFont(name: "Roboto-Medium", size: 16)
            attributeString.addAttribute(.font, value: font!, range: (text as NSString).range(of: "\(text)"))
            attributeString.addAttribute(.foregroundColor, value: UIColor(named: "HandsUpRealWhite")!, range:(text as NSString).range(of: "\(text)"))
            
            let alertController = UIAlertController(title: text, message: "", preferredStyle: UIAlertController.Style.alert)
            alertController.setValue(attributeString, forKey: "attributedTitle")
            let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
            ok.setValue(UIColor(named: "HandsUpBlue"), forKey: "titleTextColor")
            alertController.addAction(ok)
            alertController.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
            self.present(alertController, animated: false)
        }
        else {
            let text: String = "인증번호 발송에 실패했습니다"
            let attributeString = NSMutableAttributedString(string: text)
            let font = UIFont(name: "Roboto-Medium", size: 16)
            attributeString.addAttribute(.font, value: font!, range: (text as NSString).range(of: "\(text)"))
            attributeString.addAttribute(.foregroundColor, value: UIColor(named: "HandsUpRealWhite")!, range:(text as NSString).range(of: "\(text)"))
            
            let alertController = UIAlertController(title: text, message: "", preferredStyle: UIAlertController.Style.alert)
            alertController.setValue(attributeString, forKey: "attributedTitle")
            let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
            ok.setValue(UIColor(named: "HandsUpBlue"), forKey: "titleTextColor")
            alertController.addAction(ok)
            alertController.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
            self.present(alertController, animated: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.emailTextField_FindPW.addTarget(self, action: #selector(self.isIDInput(_sender:)), for: .editingChanged)
        emailTextField_FindPW.keyboardType = .emailAddress
        self.navigationController?.isNavigationBarHidden = true
        self.hideKeyboard()
    }
    
}
