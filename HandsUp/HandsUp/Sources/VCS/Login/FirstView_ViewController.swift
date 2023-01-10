import UIKit

class FirstView_ViewController: UIViewController {
    
    @IBOutlet weak var loginKakaoButton_FV: UIButton!
    @IBOutlet weak var kakaoIcon_FV: UIButton!
    @IBOutlet weak var kakaoTitle_FV: UIButton!
    @IBOutlet weak var loginAppleButton_FV: UIButton!
    @IBOutlet weak var appleIcon_FV: UIButton!
    @IBOutlet weak var appleTitle_FV: UIButton!
    @IBOutlet weak var loginGoogleButton_FV: UIButton!
    @IBOutlet weak var googleIcon_FV: UIButton!
    @IBOutlet weak var googleTitle_FV: UIButton!
    
    func buttonInit_FV(){
      
    }
    @objc func loginKakaoHighlightToggle_FV(_sender: Any){
        kakaoIcon_FV.isHighlighted.toggle()
        kakaoTitle_FV.isHighlighted.toggle()
    }
    
    @objc func loginAppleHighlightToggle_FV(_sender: Any){
        appleIcon_FV.isHighlighted.toggle()
        appleTitle_FV.isHighlighted.toggle()
    }
    
    @objc func loginGoogleHighlightToggle_FV(_sender: Any){
        googleIcon_FV.isHighlighted.toggle()
        googleTitle_FV.isHighlighted.toggle()
    }
    
    @IBAction func loginGoogleButton_FV(_ sender: Any) {
    }
    
    @IBAction func loginAppleButton_FV(_ sender: Any) {
        
    }
    @IBAction func loginKakaoButtonTap_FV(_ sender: Any) {
        
        
    }
    @IBAction func loginKakaoButtonTouchOut_FV(_ sender: Any) {
        
    }
    
    @IBAction func loginEmailButton_FV(_ sender: Any) {
        self.performSegue(withIdentifier: "showLoginEmail", sender: self)
    }
    
    func buttonHighlightInit_FV(){
        loginKakaoButton_FV.addTarget(self, action: #selector(loginKakaoHighlightToggle_FV(_sender: )), for: .touchDown)
        loginKakaoButton_FV.addTarget(self, action: #selector(loginKakaoHighlightToggle_FV(_sender: )), for: .touchUpInside)
        loginKakaoButton_FV.addTarget(self, action: #selector(loginKakaoHighlightToggle_FV(_sender: )), for: .touchUpOutside)
        loginAppleButton_FV.addTarget(self, action: #selector(loginAppleHighlightToggle_FV(_sender: )), for: .touchDown)
        loginAppleButton_FV.addTarget(self, action: #selector(loginAppleHighlightToggle_FV(_sender: )), for: .touchUpInside)
        loginAppleButton_FV.addTarget(self, action: #selector(loginAppleHighlightToggle_FV(_sender: )), for: .touchUpOutside)
        loginGoogleButton_FV.addTarget(self, action: #selector(loginGoogleHighlightToggle_FV(_sender: )), for: .touchDown)
        loginGoogleButton_FV.addTarget(self, action: #selector(loginGoogleHighlightToggle_FV(_sender: )), for: .touchUpInside)
        loginGoogleButton_FV.addTarget(self, action: #selector(loginGoogleHighlightToggle_FV(_sender: )), for: .touchUpOutside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonHighlightInit_FV()
    }
}

