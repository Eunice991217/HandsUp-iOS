import UIKit

class Profile_ViewController: UIViewController {

    @IBOutlet weak var curPageBarWidth_Profile: NSLayoutConstraint!
    @IBOutlet weak var pageControlView_Profile: RoundedShadow_UIView!
    @IBOutlet weak var titleLable_Profile: UILabel!
    @IBOutlet weak var subTitleLabe_Profile: UILabel!
    @IBOutlet weak var characterView_Profile: Character_UIView!
    @IBOutlet weak var characterButton_Profile: UIButton!
    
    func titleInit_Profile(){
        titleLable_Profile.text = "자신의 프로필\n캐릭터를 만들어봐요!"
        subTitleLabe_Profile.text = "캐릭터 클릭해 만들고\n자신만의 개성을 뽐내봐요!"
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func pageBarInit_Profile(){
        let widthValue_Profile = pageControlView_Profile.frame.size.width
        curPageBarWidth_Profile.constant = widthValue_Profile as CGFloat
    }
    @IBAction func characterButtonTap_Profile(_ sender: Any) {
        let LoginVC_FV = self.storyboard?.instantiateViewController(withIdentifier: "CharacterEdit")
        LoginVC_FV?.modalPresentationStyle = .fullScreen
        self.present(LoginVC_FV!,animated:true)
    }
    
    @IBAction func characterHighlightToggle_Profile(_ sender: Any) {
        characterView_Profile.highlightToggle()
    }
    
    @IBAction func joinHandsUpButtonTap_Profile(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleInit_Profile()
        pageBarInit_Profile()
        characterView_Profile.setCharacter()
    }
}
