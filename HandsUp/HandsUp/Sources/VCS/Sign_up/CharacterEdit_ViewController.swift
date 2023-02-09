
import UIKit

class CharacterEdit_ViewController: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var characterView_CharacterEdit: Character_UIView!
    @IBOutlet weak var scrollView_CharacterEdit: EnableButtonScroll! // tap bar
    @IBOutlet weak var selectComponentScrollView_CharacterEdit: EnableButtonScroll! // component select scroll
    @IBOutlet weak var BGButton_CharacterEdit: UIButton!
    @IBOutlet weak var faceButton_CharacterEdit: UIButton!
    @IBOutlet weak var eyebrowButton_CharacterEdit: UIButton!
    @IBOutlet weak var mouthButton_CharacterEdit: UIButton!
    @IBOutlet weak var noseButton_CharacterEdit: UIButton!
    @IBOutlet weak var eyesButton_CharacterEdit: UIButton!
    @IBOutlet weak var glassesButton_CharacterEdit: UIButton!
    @IBOutlet weak var selectView_CharacterEdit: UIView!
    @IBOutlet weak var selectViewWidth_CharacterEdit: NSLayoutConstraint!
    @IBOutlet weak var barView_CharacterEdit: UIView!
    @IBOutlet weak var barViewX_CharacterEdit: NSLayoutConstraint!
    
    let componentCount_CharacterEdit: [Int] = [2, 5, 3, 4, 4, 4, 4]
    var tabbarX_CharacterEdit: [CGFloat] = [0, 0, 0, 0, 0, 0, 0]
    var tabbarX2_CharacterEdit: [CGFloat] = [0, 0, 0, 0, 0, 0, 0]
    var barX_CharacterEdit: [NSLayoutConstraint] = []
    var buttonArray_CharacterEdit: [UIButton] = [UIButton]()
    var sign_upData_CharacterEdit: SignupData = SignupData()
    var curIndex_CharacterEdit: Int = 0
    var constraintsArray_CharacterEdit: [NSLayoutConstraint] = []
    var delegate: sendCharacterDataDelegate?
    var selectComponentOffsetX_CharacterEdit: [CGFloat] = []
    
    
    @IBAction func backButtonTap_CharacterEdit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTap_CharacterEdit(_ sender: Any) {
        delegate?.sendCharacterData(data: sign_upData_CharacterEdit)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func BGTap_CharacterEdit(_ sender: Any) {
        scrollView_CharacterEdit.setContentOffset(CGPoint(x: tabbarX_CharacterEdit[0], y: 0), animated: true)
    }
    
    @IBAction func faceTap_CharacterEdit(_ sender: Any) {
        scrollView_CharacterEdit.setContentOffset(CGPoint(x: tabbarX_CharacterEdit[1], y: 0), animated: true)
    }
    
    @IBAction func eyebrowTap_CharacterEdit(_ sender: Any) {
        scrollView_CharacterEdit.setContentOffset(CGPoint(x: tabbarX_CharacterEdit[2], y: 0), animated: true)
    }
    
    @IBAction func mouthTap_CharacterEdit(_ sender: Any) {
        scrollView_CharacterEdit.setContentOffset(CGPoint(x: tabbarX_CharacterEdit[3], y: 0), animated: true)
    }
    
    @IBAction func noseTap_CharacterEdit(_ sender: Any) {
        scrollView_CharacterEdit.setContentOffset(CGPoint(x: tabbarX_CharacterEdit[4], y: 0), animated: true)
    }
    
    @IBAction func eyesTap_CharacterEdit(_ sender: Any) {
        scrollView_CharacterEdit.setContentOffset(CGPoint(x: tabbarX_CharacterEdit[5], y: 0), animated: true)
    }
    
    @IBAction func glassesTap_CharacterEdit(_ sender: Any) {
        scrollView_CharacterEdit.setContentOffset(CGPoint(x: tabbarX_CharacterEdit[6], y: 0), animated: true)
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
        orangeButton_CharacterEdit.setImage(UIImage(named: "characterBackgroundOrange"), for: .normal)
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
        selectComponentOffsetX_CharacterEdit = [-selectComponentScrollView_CharacterEdit.contentInset.left + 75]
        for i in 1...componentCount_CharacterEdit[curIndex_CharacterEdit] - 1 {
            selectComponentOffsetX_CharacterEdit.append(selectComponentOffsetX_CharacterEdit[i-1] + 150)
        }
        
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
        tabbarX2_CharacterEdit[0] = tabbarX_CharacterEdit[0] + 20 + BGButton_CharacterEdit.frame.width
        tabbarX_CharacterEdit[1] = tabbarX_CharacterEdit[0] + 40 + BGButton_CharacterEdit.frame.width
        tabbarX2_CharacterEdit[1] = tabbarX_CharacterEdit[1] + 20 + faceButton_CharacterEdit.frame.width
        tabbarX_CharacterEdit[2] = tabbarX_CharacterEdit[1] + 40 + faceButton_CharacterEdit.frame.width
        tabbarX2_CharacterEdit[2] = tabbarX_CharacterEdit[2] + 20 + eyebrowButton_CharacterEdit.frame.width
        tabbarX_CharacterEdit[3] = tabbarX_CharacterEdit[2] + 40 + eyebrowButton_CharacterEdit.frame.width
        tabbarX2_CharacterEdit[3] = tabbarX_CharacterEdit[3] + 20 + mouthButton_CharacterEdit.frame.width
        tabbarX_CharacterEdit[4] = tabbarX_CharacterEdit[3] + 40 + mouthButton_CharacterEdit.frame.width
        tabbarX2_CharacterEdit[4] = tabbarX_CharacterEdit[4] + 20 + noseButton_CharacterEdit.frame.width
        tabbarX_CharacterEdit[5] = tabbarX_CharacterEdit[4] + 40 + noseButton_CharacterEdit.frame.width
        tabbarX2_CharacterEdit[5] = tabbarX_CharacterEdit[5] + 20 + eyesButton_CharacterEdit.frame.width
        tabbarX_CharacterEdit[6] = tabbarX_CharacterEdit[5] + 40 + eyesButton_CharacterEdit.frame.width
        tabbarX2_CharacterEdit[6] = tabbarX_CharacterEdit[6] + 20 + glassesButton_CharacterEdit.frame.width
        
        buttonArray_CharacterEdit.forEach{
            barX_CharacterEdit.append(barView_CharacterEdit.centerXAnchor.constraint(equalTo: $0.centerXAnchor))
        }
        barX_CharacterEdit.append(barViewX_CharacterEdit)
        
        moveBar_CharacterEdit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterView_CharacterEdit.setCharacter(componentArray: sign_upData_CharacterEdit.characterComponent)
        tabbarInit_CharacterEdit()
        BGSelect_CharacterEdit()
        tabbarXInit_CharacterEdit()
        scrollView_CharacterEdit.delegate = self
    }
    
    func moveBar_CharacterEdit(){
        barX_CharacterEdit.forEach{
            $0.isActive = false
        }
        barX_CharacterEdit[curIndex_CharacterEdit].isActive = true
    }
    
    func scrollContent_CharacterEdit(){
        if(curIndex_CharacterEdit == 0){
            selectComponentScrollView_CharacterEdit.setContentOffset(CGPoint(x: -selectComponentScrollView_CharacterEdit.contentInset.left + CGFloat(sign_upData_CharacterEdit.characterComponent[curIndex_CharacterEdit] * 118), y: 0), animated: true)
        }else{
            selectComponentScrollView_CharacterEdit.setContentOffset(CGPoint(x: -selectComponentScrollView_CharacterEdit.contentInset.left + CGFloat(sign_upData_CharacterEdit.characterComponent[curIndex_CharacterEdit] * 150), y: 0), animated: true)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView_CharacterEdit.setContentOffset(CGPoint(x: tabbarX_CharacterEdit[curIndex_CharacterEdit], y: 0), animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate{
            scrollView_CharacterEdit.setContentOffset(CGPoint(x: tabbarX_CharacterEdit[curIndex_CharacterEdit], y: 0), animated: true)

        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //tapbar
        for i in 0...6{
            if(self.scrollView_CharacterEdit.contentOffset.x < tabbarX2_CharacterEdit[i]){
                if(curIndex_CharacterEdit != i){
                    deselectTab_CharacterEdit()
                    curIndex_CharacterEdit = i
                    selectTab_CharacterEdit()
                    if(i == 0){
                        BGSelect_CharacterEdit()
                        selectComponentScrollView_CharacterEdit.setContentOffset(CGPoint(x: -selectComponentScrollView_CharacterEdit.contentInset.left + CGFloat(sign_upData_CharacterEdit.characterComponent[curIndex_CharacterEdit] * 158), y: 0), animated: true)
                    }else{
                        characterComponentSelect_CharacterEdit()
                        selectComponentScrollView_CharacterEdit.setContentOffset(CGPoint(x: -selectComponentScrollView_CharacterEdit.contentInset.left + CGFloat(sign_upData_CharacterEdit.characterComponent[curIndex_CharacterEdit] * 150), y: 0), animated: true)
                    }
                    moveBar_CharacterEdit()
                }
                break
            }
        }
    }
    
    func characterComponentInit(dataArr: [Int]){
        var index = 0
        dataArr.forEach{
            sign_upData_CharacterEdit.characterComponent[index] = $0
            index += 1
        }
    }
    
    @objc func select0(_ sender: Any){
        sign_upData_CharacterEdit.characterComponent[curIndex_CharacterEdit] = 0
        characterView_CharacterEdit.setCharacter(componentArray: sign_upData_CharacterEdit.characterComponent)
        scrollContent_CharacterEdit()
    }
    
    @objc func select1(_ sender: Any){
        sign_upData_CharacterEdit.characterComponent[curIndex_CharacterEdit] = 1
        characterView_CharacterEdit.setCharacter(componentArray: sign_upData_CharacterEdit.characterComponent)
        scrollContent_CharacterEdit()
    }
    
    @objc func select2(_ sender: Any){
        sign_upData_CharacterEdit.characterComponent[curIndex_CharacterEdit] = 2
        characterView_CharacterEdit.setCharacter(componentArray: sign_upData_CharacterEdit.characterComponent)
        scrollContent_CharacterEdit()
    }
    
    @objc func select3(_ sender: Any){
        sign_upData_CharacterEdit.characterComponent[curIndex_CharacterEdit] = 3
        characterView_CharacterEdit.setCharacter(componentArray: sign_upData_CharacterEdit.characterComponent)
        scrollContent_CharacterEdit()
    }
    
    @objc func select4(_ sender: Any){
        sign_upData_CharacterEdit.characterComponent[curIndex_CharacterEdit] = 4
        characterView_CharacterEdit.setCharacter(componentArray: sign_upData_CharacterEdit.characterComponent)
        scrollContent_CharacterEdit()
    }
    
}

protocol sendCharacterDataDelegate{
    func sendCharacterData(data: SignupData)
}
