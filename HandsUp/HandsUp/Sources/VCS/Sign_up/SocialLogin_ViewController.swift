import UIKit

class SocialLogin_ViewController: UIViewController {

    @IBOutlet weak var curPageBarX_SocialLogin: NSLayoutConstraint!
    @IBOutlet weak var curPageBarWidth_SocialLogin: NSLayoutConstraint!
    @IBOutlet weak var pageControlView_SocialLogin: RoundedShadow_UIView!
    @IBOutlet weak var titleLable_SocialLogin: UILabel!
    
    
    func titleInit_SocialLogin(){
        titleLable_SocialLogin.text = "학교확인\n도와드릴게요"
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func pageBarInit_SocialLogin(){
        let widthValue_SocialLogin = pageControlView_SocialLogin.frame.size.width / 5
        curPageBarX_SocialLogin.constant = widthValue_SocialLogin * 2
        curPageBarWidth_SocialLogin.constant = widthValue_SocialLogin as CGFloat
    }
    @IBAction func nextButtonTap_SocialLogin(_ sender: Any) {
        let nicknameVC_SocialLogin = self.storyboard?.instantiateViewController(withIdentifier: "Nickname")
        self.navigationController?.pushViewController(nicknameVC_SocialLogin!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleInit_SocialLogin()
        pageBarInit_SocialLogin()
    }
    

}
