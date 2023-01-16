
import UIKit

class CharacterEdit_ViewController: UIViewController {
    
    @IBOutlet weak var characterView_CharacterEdit: Character_UIView!
    @IBOutlet weak var scrollView_CharacterEdit: UIScrollView! // tap bar
    @IBOutlet weak var selectComponentScrollView_CharacterEdit: UIScrollView! // component select scroll
    @IBOutlet weak var BGButton_CharacterEdit: UIButton!
    @IBOutlet weak var faceButton_CharacterEdit: UIButton!
    @IBOutlet weak var eyebrowButton_CharacterEdit: UIButton!
    @IBOutlet weak var mouthButton_CharacterEdit: UIButton!
    @IBOutlet weak var noseButton_CharacterEdit: UIButton!
    @IBOutlet weak var eyesButton_CharacterEdit: UIButton!
    @IBOutlet weak var glassesButton_CharacterEdit: UIButton!
    @IBOutlet weak var selectView_CharacterEdit: UIView!
    @IBOutlet weak var selectViewWidth_CharacterEdit: NSLayoutConstraint!
    
    let componentCount_CharacterEdit: [Int] = [2, 5, 3, 4, 4, 4, 4]
    var tabbarX_CharacterEdit: [CGFloat] = [0, 0, 0, 0, 0, 0, 0]
    var buttonArray_CharacterEdit: [UIButton] = [UIButton]()
    var sign_upData_CharacterEdit: SignupData = SignupData()
    var curIndex_CharacterEdit: Int = 0
    var constraintsArray_CharacterEdit: [NSLayoutConstraint] = []
    var delegate: sendCharacterDataDelegate?
    
    
    @IBAction func backButtonTap_CharacterEdit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTap_CharacterEdit(_ sender: Any) {
        delegate?.sendCharacterData(data: sign_upData_CharacterEdit)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func BGTap_CharacterEdit(_ sender: Any) {
        if(curIndex_CharacterEdit != 0){
            deselectTab_CharacterEdit()
            curIndex_CharacterEdit = 0
            selectTab_CharacterEdit()
            BGSelect_CharacterEdit()
            
            scrollView_CharacterEdit.setContentOffset(CGPoint(x: tabbarX_CharacterEdit[0], y: 0), animated: true)
            selectComponentScrollView_CharacterEdit.setContentOffset(CGPoint(x: -selectComponentScrollView_CharacterEdit.contentInset.left, y: 0), animated: true)
        }
    }
    
    @IBAction func faceTap_CharacterEdit(_ sender: Any) {
        if(curIndex_CharacterEdit != 1){
            deselectTab_CharacterEdit()
            curIndex_CharacterEdit = 1
            selectTab_CharacterEdit()
            characterComponentSelect_CharacterEdit()
            scrollView_CharacterEdit.setContentOffset(CGPoint(x: tabbarX_CharacterEdit[1], y: 0), animated: true)
            selectComponentScrollView_CharacterEdit.setContentOffset(CGPoint(x: -selectComponentScrollView_CharacterEdit.contentInset.left, y: 0), animated: true)
        }
    }
    
    @IBAction func eyebrowTap_CharacterEdit(_ sender: Any) {
        if(curIndex_CharacterEdit != 2){
            deselectTab_CharacterEdit()
            curIndex_CharacterEdit = 2
            selectTab_CharacterEdit()
            characterComponentSelect_CharacterEdit()
            scrollView_CharacterEdit.setContentOffset(CGPoint(x: tabbarX_CharacterEdit[2], y: 0), animated: true)
            selectComponentScrollView_CharacterEdit.setContentOffset(CGPoint(x: -selectComponentScrollView_CharacterEdit.contentInset.left, y: 0), animated: true)
        }
    }
    
    @IBAction func mouthTap_CharacterEdit(_ sender: Any) {
        if(curIndex_CharacterEdit != 3){
            deselectTab_CharacterEdit()
            curIndex_CharacterEdit = 3
            selectTab_CharacterEdit()
            characterComponentSelect_CharacterEdit()
            scrollView_CharacterEdit.setContentOffset(CGPoint(x: tabbarX_CharacterEdit[3], y: 0), animated: true)
            selectComponentScrollView_CharacterEdit.setContentOffset(CGPoint(x: -selectComponentScrollView_CharacterEdit.contentInset.left, y: 0), animated: true)
        }
    }
    
    @IBAction func noseTap_CharacterEdit(_ sender: Any) {
        if(curIndex_CharacterEdit != 4){
            deselectTab_CharacterEdit()
            curIndex_CharacterEdit = 4
            selectTab_CharacterEdit()
            characterComponentSelect_CharacterEdit()
            scrollView_CharacterEdit.setContentOffset(CGPoint(x: tabbarX_CharacterEdit[4], y: 0), animated: true)
            selectComponentScrollView_CharacterEdit.setContentOffset(CGPoint(x: -selectComponentScrollView_CharacterEdit.contentInset.left, y: 0), animated: true)
        }
    }
    
    @IBAction func eyesTap_CharacterEdit(_ sender: Any) {
        if(curIndex_CharacterEdit != 5){
            deselectTab_CharacterEdit()
            curIndex_CharacterEdit = 5
            selectTab_CharacterEdit()
            characterComponentSelect_CharacterEdit()
            scrollView_CharacterEdit.setContentOffset(CGPoint(x: tabbarX_CharacterEdit[5], y: 0), animated: true)
            selectComponentScrollView_CharacterEdit.setContentOffset(CGPoint(x: -selectComponentScrollView_CharacterEdit.contentInset.left, y: 0), animated: true)
        }
    }
    
    @IBAction func glassesTap_CharacterEdit(_ sender: Any) {
        if(curIndex_CharacterEdit != 6){
            deselectTab_CharacterEdit()
            curIndex_CharacterEdit = 6
            selectTab_CharacterEdit()
            characterComponentSelect_CharacterEdit()
            scrollView_CharacterEdit.setContentOffset(CGPoint(x: tabbarX_CharacterEdit[6], y: 0), animated: true)
            selectComponentScrollView_CharacterEdit.setContentOffset(CGPoint(x: -selectComponentScrollView_CharacterEdit.contentInset.left, y: 0), animated: true)
        }
    }
    
    func deselectTab_CharacterEdit(){
        buttonArray_CharacterEdit[curIndex_CharacterEdit].titleLabel?.font = UIFont(name: "Roboto-Midium", size: 16)
        buttonArray_CharacterEdit[curIndex_CharacterEdit].setTitleColor(UIColor(named: "HandsUpGrey"), for: .normal)
    }
    
    func selectTab_CharacterEdit(){
        buttonArray_CharacterEdit[curIndex_CharacterEdit].titleLabel?.font = UIFont(name: "Roboto-Bold", size: 18)
        buttonArray_CharacterEdit[curIndex_CharacterEdit].setTitleColor(UIColor(named: "HandsUpBlue"), for: .normal)
    }
    
    func tabbarInit_CharacterEdit(){
        buttonArray_CharacterEdit = [BGButton_CharacterEdit, faceButton_CharacterEdit, eyebrowButton_CharacterEdit, mouthButton_CharacterEdit,noseButton_CharacterEdit, eyesButton_CharacterEdit, glassesButton_CharacterEdit]
        selectTab_CharacterEdit()
        let insetWidth_CharacterEdit = (UIScreen.main.bounds.size.width - BGButton_CharacterEdit.frame.width) / 2
        scrollView_CharacterEdit.contentInset.left = insetWidth_CharacterEdit
        scrollView_CharacterEdit.contentInset.right = insetWidth_CharacterEdit
    }
    
    func BGSelect_CharacterEdit(){
        constraintsArray_CharacterEdit.forEach{
            $0.isActive = false
        }
        for subviews_CharacterEdit in selectView_CharacterEdit.subviews {
            subviews_CharacterEdit.removeFromSuperview()
        }
        
        let orangeButton_CharacterEdit: UIButton = UIButton()
        orangeButton_CharacterEdit.setImage(UIImage(named: "CharacterBackgroundOrange"), for: .normal)
        orangeButton_CharacterEdit.translatesAutoresizingMaskIntoConstraints = false
        orangeButton_CharacterEdit.addTarget(self, action: #selector(select0(_:)), for: .touchUpInside)
        let blueButton_CharacterEdit: UIButton = UIButton()
        blueButton_CharacterEdit.setImage(UIImage(named: "characterBackgroundBlue"), for: .normal)
        blueButton_CharacterEdit.translatesAutoresizingMaskIntoConstraints = false
        blueButton_CharacterEdit.addTarget(self, action: #selector(select1(_:)), for: .touchUpInside)
        
        selectView_CharacterEdit.backgroundColor = .clear
        selectViewWidth_CharacterEdit.constant = 196
        selectView_CharacterEdit.addSubview(orangeButton_CharacterEdit)
        selectView_CharacterEdit.addSubview(blueButton_CharacterEdit)
        constraintsArray_CharacterEdit = [
            orangeButton_CharacterEdit.heightAnchor.constraint(equalToConstant: 78),
            orangeButton_CharacterEdit.widthAnchor.constraint(equalToConstant: 78),
            blueButton_CharacterEdit.heightAnchor.constraint(equalToConstant: 78),
            blueButton_CharacterEdit.widthAnchor.constraint(equalToConstant: 78),
            orangeButton_CharacterEdit.leftAnchor.constraint(equalTo: selectView_CharacterEdit.leftAnchor),
            orangeButton_CharacterEdit.centerYAnchor.constraint(equalTo: selectView_CharacterEdit.centerYAnchor),
            blueButton_CharacterEdit.leftAnchor.constraint(equalTo: orangeButton_CharacterEdit.rightAnchor, constant: 40),
            blueButton_CharacterEdit.centerYAnchor.constraint(equalTo: selectView_CharacterEdit.centerYAnchor)
        ]
        
        constraintsArray_CharacterEdit.forEach{
            $0.isActive = true
        }
        
        let insetWidth_CharacterEdit = (UIScreen.main.bounds.size.width - 78) / 2
        selectComponentScrollView_CharacterEdit.contentInset.left = insetWidth_CharacterEdit
        selectComponentScrollView_CharacterEdit.contentInset.right = insetWidth_CharacterEdit
    }
    
    func characterComponentSelect_CharacterEdit(){
        constraintsArray_CharacterEdit.forEach{
            $0.isActive = false
        }
        
        for subviews_CharacterEdit in selectView_CharacterEdit.subviews {
            subviews_CharacterEdit.removeFromSuperview()
        }
        
        let characterSelect0_CharacterEdit: Character_UIView = Character_UIView()
        let characterSelect1_CharacterEdit: Character_UIView = Character_UIView()
        let characterSelect2_CharacterEdit: Character_UIView = Character_UIView()
        let characterSelect3_CharacterEdit: Character_UIView = Character_UIView()
        let characterSelect4_CharacterEdit: Character_UIView = Character_UIView()
        let characterSelectArray_CharacterEdit: [Character_UIView] = [characterSelect0_CharacterEdit,characterSelect1_CharacterEdit,characterSelect2_CharacterEdit,characterSelect3_CharacterEdit,characterSelect4_CharacterEdit]
        
        let characterSelect0Button_CharacterEdit: UIButton = UIButton()
        let characterSelect1Button_CharacterEdit: UIButton = UIButton()
        let characterSelect2Button_CharacterEdit: UIButton = UIButton()
        let characterSelect3Button_CharacterEdit: UIButton = UIButton()
        let characterSelect4Button_CharacterEdit: UIButton = UIButton()
        let characterSelectButtonArray_CharacterEdit: [UIButton] = [characterSelect0Button_CharacterEdit,characterSelect1Button_CharacterEdit,characterSelect2Button_CharacterEdit,characterSelect3Button_CharacterEdit,characterSelect4Button_CharacterEdit]
        
        characterSelect0Button_CharacterEdit.addTarget(self, action: #selector(select0(_:)), for: .touchUpInside)
        characterSelect1Button_CharacterEdit.addTarget(self, action: #selector(select1(_:)), for: .touchUpInside)
        characterSelect2Button_CharacterEdit.addTarget(self, action: #selector(select2(_:)), for: .touchUpInside)
        characterSelect3Button_CharacterEdit.addTarget(self, action: #selector(select3(_:)), for: .touchUpInside)
        characterSelect4Button_CharacterEdit.addTarget(self, action: #selector(select4(_:)), for: .touchUpInside)
        
        selectView_CharacterEdit.backgroundColor = .clear
        selectViewWidth_CharacterEdit.constant = CGFloat(150 * componentCount_CharacterEdit[curIndex_CharacterEdit] - 40)
        constraintsArray_CharacterEdit = []
        for tmp in 0...componentCount_CharacterEdit[curIndex_CharacterEdit] - 1{
            characterSelectArray_CharacterEdit[tmp].translatesAutoresizingMaskIntoConstraints = false
            characterSelectButtonArray_CharacterEdit[tmp].translatesAutoresizingMaskIntoConstraints = false
            var tmpArray = sign_upData_CharacterEdit.characterComponent
            tmpArray[curIndex_CharacterEdit] = tmp
            characterSelectArray_CharacterEdit[tmp].setAll(componentArray: tmpArray)
            selectView_CharacterEdit.addSubview(characterSelectArray_CharacterEdit[tmp])
            selectView_CharacterEdit.addSubview(characterSelectButtonArray_CharacterEdit[tmp])
            characterSelectArray_CharacterEdit[tmp].frame.size.width = 110
            characterSelectArray_CharacterEdit[tmp].frame.size.height = 110 * 406 / 288
            constraintsArray_CharacterEdit.append(characterSelectButtonArray_CharacterEdit[tmp].widthAnchor.constraint(equalToConstant: characterSelectArray_CharacterEdit[tmp].frame.width))
            constraintsArray_CharacterEdit.append(characterSelectButtonArray_CharacterEdit[tmp].heightAnchor.constraint(equalToConstant: characterSelectArray_CharacterEdit[tmp].frame.height))
            constraintsArray_CharacterEdit.append(characterSelectArray_CharacterEdit[tmp].widthAnchor.constraint(equalToConstant: characterSelectArray_CharacterEdit[tmp].frame.width))
            constraintsArray_CharacterEdit.append(characterSelectArray_CharacterEdit[tmp].heightAnchor.constraint(equalToConstant: characterSelectArray_CharacterEdit[tmp].frame.height))
            constraintsArray_CharacterEdit.append(characterSelectArray_CharacterEdit[tmp].centerYAnchor.constraint(equalTo: selectView_CharacterEdit.centerYAnchor))
            constraintsArray_CharacterEdit.append(characterSelectButtonArray_CharacterEdit[tmp].centerYAnchor.constraint(equalTo: selectView_CharacterEdit.centerYAnchor))
            if(tmp > 0){
                constraintsArray_CharacterEdit.append(characterSelectArray_CharacterEdit[tmp].leftAnchor.constraint(equalTo: characterSelectArray_CharacterEdit[tmp - 1].leftAnchor, constant: 150))
                constraintsArray_CharacterEdit.append(characterSelectButtonArray_CharacterEdit[tmp].leftAnchor.constraint(equalTo: characterSelectButtonArray_CharacterEdit[tmp - 1].leftAnchor, constant: 150))
            }else{
                constraintsArray_CharacterEdit.append(characterSelectArray_CharacterEdit[0].leftAnchor.constraint(equalTo: selectView_CharacterEdit.leftAnchor))
                constraintsArray_CharacterEdit.append(characterSelectButtonArray_CharacterEdit[0].leftAnchor.constraint(equalTo: selectView_CharacterEdit.leftAnchor))
            }
        }
        
        constraintsArray_CharacterEdit.forEach {
            $0.isActive = true
        }
        
        for tmp in 0...componentCount_CharacterEdit[curIndex_CharacterEdit] - 1{
            characterSelectArray_CharacterEdit[tmp].setCharacterOnly()
        }
        
        let insetWidth_CharacterEdit = (UIScreen.main.bounds.size.width - 110) / 2
        selectComponentScrollView_CharacterEdit.contentInset.left = insetWidth_CharacterEdit
        selectComponentScrollView_CharacterEdit.contentInset.right = insetWidth_CharacterEdit
    }
    
    
    func tabbarXInit_CharacterEdit(){
        tabbarX_CharacterEdit[0] = -scrollView_CharacterEdit.contentInset.left
        tabbarX_CharacterEdit[1] = tabbarX_CharacterEdit[0] + 40 + BGButton_CharacterEdit.frame.width
        tabbarX_CharacterEdit[2] = tabbarX_CharacterEdit[1] + 40 + faceButton_CharacterEdit.frame.width
        tabbarX_CharacterEdit[3] = tabbarX_CharacterEdit[2] + 40 + eyebrowButton_CharacterEdit.frame.width
        tabbarX_CharacterEdit[4] = tabbarX_CharacterEdit[3] + 40 + mouthButton_CharacterEdit.frame.width
        tabbarX_CharacterEdit[5] = tabbarX_CharacterEdit[4] + 40 + noseButton_CharacterEdit.frame.width
        tabbarX_CharacterEdit[6] = tabbarX_CharacterEdit[5] + 40 + eyesButton_CharacterEdit.frame.width
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterView_CharacterEdit.setCharacter(componentArray: sign_upData_CharacterEdit.characterComponent)
        tabbarInit_CharacterEdit()
        BGSelect_CharacterEdit()
        tabbarXInit_CharacterEdit()
    }
    
    @objc func select0(_ sender: Any){
        sign_upData_CharacterEdit.characterComponent[curIndex_CharacterEdit] = 0
        characterView_CharacterEdit.setCharacter(componentArray: sign_upData_CharacterEdit.characterComponent)
    }
    
    @objc func select1(_ sender: Any){
        sign_upData_CharacterEdit.characterComponent[curIndex_CharacterEdit] = 1
        characterView_CharacterEdit.setCharacter(componentArray: sign_upData_CharacterEdit.characterComponent)
    }
    
    @objc func select2(_ sender: Any){
        sign_upData_CharacterEdit.characterComponent[curIndex_CharacterEdit] = 2
        characterView_CharacterEdit.setCharacter(componentArray: sign_upData_CharacterEdit.characterComponent)
    }
    
    @objc func select3(_ sender: Any){
        sign_upData_CharacterEdit.characterComponent[curIndex_CharacterEdit] = 3
        characterView_CharacterEdit.setCharacter(componentArray: sign_upData_CharacterEdit.characterComponent)
    }
    
    @objc func select4(_ sender: Any){
        sign_upData_CharacterEdit.characterComponent[curIndex_CharacterEdit] = 4
        characterView_CharacterEdit.setCharacter(componentArray: sign_upData_CharacterEdit.characterComponent)
    }
    
}
protocol sendCharacterDataDelegate{
    func sendCharacterData(data: SignupData)
}
