import UIKit

class Sign_up1_ViewController: UIViewController {
    
    @IBOutlet weak var titleLable_Sign_up1: UILabel!
    
    @IBOutlet weak var nextButton_Sign_up1: UIButton!
    var isNextButtonActive_Sign_up1:Bool = false
    
    @IBOutlet weak var curPageBarX_Sign_up1: NSLayoutConstraint!
    @IBOutlet weak var curPageBarWidth_Sign_up1: NSLayoutConstraint!
    @IBOutlet weak var pageControlView_Sign_up1: RoundedShadow_UIView!
    @IBOutlet weak var checkBox1_Sign_up1: UIButton!
    @IBOutlet weak var checkBox2_Sign_up1: UIButton!
    @IBOutlet weak var checkBox3_Sign_up1: UIButton!
    @IBOutlet weak var checkBox4_Sign_up1: UIButton!
    var checkBox_Sign_up1 =  [Bool](repeating: false, count: 4)
    
    func pageBarInit_Sign_up1(){
        let widthValue_Sign_up1 = pageControlView_Sign_up1.frame.size.width / 5 as CGFloat
        curPageBarX_Sign_up1.constant = 0
        curPageBarWidth_Sign_up1.constant = widthValue_Sign_up1
    }
    
    func titleInit_Sign_up1(){
        titleLable_Sign_up1.text = "대학생 여러분 \n환영합니다:)"
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func checkBoxInit_Sign_up1(){
        checkBox1_Sign_up1.setImage(nil, for: .normal)
        checkBox2_Sign_up1.setImage(nil, for: .normal)
        checkBox3_Sign_up1.setImage(nil, for: .normal)
        checkBox4_Sign_up1.setImage(nil, for: .normal)
    }
    
    func checkAllAgree_Sign_up1()->Bool{
        for tmp_Sign_up1 in checkBox_Sign_up1{
            if(!tmp_Sign_up1){
                return false
            }
        }
        return true
    }
    
    func changeNextButtonState_Sign_up1(){
        if(checkAllAgree_Sign_up1()){
            nextButton_Sign_up1.backgroundColor = UIColor(named: "HandsUpOrange")
            self.isNextButtonActive_Sign_up1 = true
        }
        else{
            nextButton_Sign_up1.backgroundColor = UIColor(named: "HandsUpWhiteGrey")
            self.isNextButtonActive_Sign_up1 = false
        }
    }
    
    @IBAction func checkBox1Tap_Sign_up1(_ sender: Any){
        if(checkBox_Sign_up1[0]){
            checkBox1_Sign_up1.setImage(nil, for: .normal)
            checkBox_Sign_up1[0] = false
        }else{
            checkBox1_Sign_up1.setImage(UIImage(named: "OrangeCheck"), for: .normal)
            checkBox_Sign_up1[0] = true
        }
        changeNextButtonState_Sign_up1()
    }
    
    @IBAction func checkBox2Tap_Sign_up1(_ sender: Any){
        if(checkBox_Sign_up1[1]){
            checkBox2_Sign_up1.setImage(nil, for: .normal)
            checkBox_Sign_up1[1] = false
        }else{
            checkBox2_Sign_up1.setImage(UIImage(named: "OrangeCheck"), for: .normal)
            checkBox_Sign_up1[1] = true
        }
        changeNextButtonState_Sign_up1()
    }
    
    @IBAction func checkBox3Tap_Sign_up1(_ sender: Any){
        if(checkBox_Sign_up1[2]){
            checkBox3_Sign_up1.setImage(nil, for: .normal)
            checkBox_Sign_up1[2] = false
        }else{
            checkBox3_Sign_up1.setImage(UIImage(named: "OrangeCheck"), for: .normal)
            checkBox_Sign_up1[2] = true
        }
        changeNextButtonState_Sign_up1()
    }
    
    @IBAction func checkBox4Tap_Sign_up1(_ sender: Any){
        if(checkBox_Sign_up1[3]){
            checkBox4_Sign_up1.setImage(nil, for: .normal)
            checkBox_Sign_up1[3] = false
        }else{
            checkBox4_Sign_up1.setImage(UIImage(named: "OrangeCheck"), for: .normal)
            checkBox_Sign_up1[3] = true
        }
        changeNextButtonState_Sign_up1()
    }
    
    @IBAction func nextButtonTap_Sign_up1(_ sender: Any) {
        if(isNextButtonActive_Sign_up1){
            let sign_up2VC_Sign_up1 = self.storyboard?.instantiateViewController(withIdentifier: "Sign_up2")
            self.navigationController?.pushViewController(sign_up2VC_Sign_up1!, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleInit_Sign_up1()
        pageBarInit_Sign_up1()
        checkBoxInit_Sign_up1()
    }
}
