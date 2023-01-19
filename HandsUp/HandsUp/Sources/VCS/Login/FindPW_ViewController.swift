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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.emailTextField_FindPW.addTarget(self, action: #selector(self.isIDInput(_sender:)), for: .editingChanged)
        emailTextField_FindPW.keyboardType = .emailAddress
        self.navigationController?.isNavigationBarHidden = true
        self.hideKeyboard()
    }
    
}
