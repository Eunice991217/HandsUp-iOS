import UIKit

class Sign_up1_ViewController: UIViewController {
    
    @IBOutlet weak var titleLable_Sign_up1: UILabel!
    
    @IBOutlet weak var nextButton_Sign_up1: UIButton!
    var isNextButtleActive_Sign_up1:Bool = false
    
    @IBOutlet weak var curPageBarX_Sign_up1: NSLayoutConstraint!
    @IBOutlet weak var curPageBarWidth_Sign_up1: NSLayoutConstraint!
    @IBOutlet weak var pageControlView_Sign_up1: RoundedShadow_UIView!
    
    func pageBarInit(){
        let widthValue_Sign_up1 = pageControlView_Sign_up1.frame.size.width / 5 as CGFloat
        curPageBarX_Sign_up1.constant = 0
        curPageBarWidth_Sign_up1.constant = widthValue_Sign_up1
    }
    
    func titleInit(){
        titleLable_Sign_up1.text = "대학생 여러분 \n환영합니다:)"
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func checkAllAgree_Sign_up1()->Bool{
        
        return true
    }
    
    @objc func changeNextButtonState_Sign_up1(_ sender: Any){
        if(checkAllAgree_Sign_up1()){
            nextButton_Sign_up1.backgroundColor = UIColor(named: "HandsUpOrange")
            self.isNextButtleActive_Sign_up1 = true
        }
        else{
            nextButton_Sign_up1.backgroundColor = UIColor(named: "HandsUpWhiteGrey")
            self.isNextButtleActive_Sign_up1 = false
        }
    }
    
    @IBAction func nextButtonTap_Sign_up1(_ sender: Any) {
        if(isNextButtleActive_Sign_up1){
            let sign_up2VC_Sign_up1 = self.storyboard?.instantiateViewController(withIdentifier: "Sign_up2")
            self.navigationController?.pushViewController(sign_up2VC_Sign_up1!, animated: true)
        }
        isNextButtleActive_Sign_up1=true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleInit()
        pageBarInit()
    }
}
