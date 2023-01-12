import UIKit

class Character_UIView: UIView {
    var eyesType:Int = 0
    var eyebrowType:Int = 0
    var noseType:Int = 0
    var mouthType:Int = 0
    var glassesType:Int = 0
    var headType:Int = 0
    var bgType:Int = 0
    var eyesButton:UIButton = UIButton()
    var eyebrowButton:UIButton = UIButton()
    var noseButton:UIButton = UIButton()
    var mouthButton:UIButton = UIButton()
    var glassesButton:UIButton = UIButton()
    var headButton:UIButton = UIButton()
    var bgButton:UIButton = UIButton()
    let eyesImages:[String] = ["characterEyes1", "characterEyes2", "characterEyes3", "characterEyes4"]
    let eyebrowImages:[String] = ["characterEyebrow1", "characterEyebrow2", "characterEyebrow3"]
    let noseImages:[String] = ["characterNose1", "characterNose2", "characterNose3", "characterNose4"]
    let mouthImages:[String] = ["characterMouth1", "characterMouth2", "characterMouth3", "characterMouth4"]
    let glassesImages:[String] = ["", "characterGlasses1", "characterGlasses2", "characterSunglasses"]
    let headImages:[String] = ["characterHeadCurly", "characterHeadShort", "characterHeadBald", "characterHeadBeanie", "characterHeadPomade"]
    let bgImages:[String] = ["CharacterBackgroundOrange", "characterBackgroundBlue"]
    let eyesWidth:[CGFloat] = [100, 100, 103, 118]
    let eyesHeight:[CGFloat] = [41, 41, 19, 22]
    let eyesBottomEdges:[CGFloat] = [162, 162, 176, 172]
    let eyebrowWidth:CGFloat = 88
    let eyebrowHeight:[CGFloat] = [13, 8, 8]
    let eyebrowBottomEdges:[CGFloat] = [204, 209, 209]
    let noseWidth:[CGFloat] = [30, 40, 27, 33]
    let noseHeight:[CGFloat] = [66, 62, 46, 80]
    let noseBottomEdges:[CGFloat] = [136, 133, 134, 123]
    let mouthWidth:[CGFloat] = [74, 72, 59, 56]
    let mouthHeight:[CGFloat] = [26, 40, 20, 38]
    let mouthBottomEdges:[CGFloat] = [107, 98, 110, 94]
    let glassesWidth:[CGFloat] = [0, 212, 213, 165]
    let glassesHeight:[CGFloat] = [0, 50, 54, 54]
    let glassesBottomEdges:[CGFloat] = [0, 153, 154, 151]
    let headWidth:CGFloat = 288
    let headHeight:[CGFloat] = [385, 350, 314, 341, 315]
    
    func setEyesType(EyesType : Int){
        self.eyesType = EyesType
    }
    
    func setEyebrowType(EyebrowType : Int){
        self.eyebrowType = EyebrowType
    }
    
    func setNosesType(NoseType : Int){
        self.noseType = NoseType
    }
    
    func setMouthType(MouthType : Int){
        self.mouthType = MouthType
    }
    
    func setGlassesType(GlassesType : Int){
        self.glassesType = GlassesType
    }
    
    func setHeadType(HeadType : Int){
        self.headType = HeadType
    }
    
    func setBgType(BgType : Int){
        self.bgType = BgType
    }
    
    func setAll(EyesType : Int, EyebrowType : Int, NoseType : Int, MouthType : Int, GlassesType : Int, HeadType : Int, BgType : Int ){
        self.eyesType = EyesType
        self.eyebrowType = EyebrowType
        self.noseType = NoseType
        self.mouthType = MouthType
        self.glassesType = GlassesType
        self.headType = HeadType
        self.bgType = BgType
    }
    
    func highlightToggle(){
        eyesButton.isHighlighted.toggle()
        eyebrowButton.isHighlighted.toggle()
        noseButton.isHighlighted.toggle()
        mouthButton.isHighlighted.toggle()
        glassesButton.isHighlighted.toggle()
        headButton.isHighlighted.toggle()
        bgButton.isHighlighted.toggle()
    }
    func setShadow(superview: UIView){
        bgButton.layer.shadowColor = UIColor.black.cgColor
        bgButton.layer.shadowRadius = 45 / UIScreen.main.scale
        bgButton.layer.shadowOffset = CGSize(width: 0, height: 160)
        bgButton.layer.shadowOpacity = 0
        let shadow1: UIButton = UIButton()
        let shadow2: UIButton = UIButton()
        let shadow3: UIButton = UIButton()
        let shadow4: UIButton = UIButton()
        let shadow5: UIButton = UIButton()
        let shadowArray: [UIButton] = [shadow1, shadow2, shadow3, shadow4, shadow5]
        shadowArray.forEach {
            $0.layer.masksToBounds = false
            $0.layer.shadowColor = UIColor.black.cgColor
        }
    }
    
    func setCharacter(){
        eyesButton = UIButton()
        eyebrowButton = UIButton()
        noseButton = UIButton()
        mouthButton = UIButton()
        glassesButton = UIButton()
        headButton = UIButton()
        bgButton = UIButton()
        
        
        let viewWidth = self.frame.width
        let viewHeight = self.frame.height
        let length = viewWidth < viewHeight ? viewWidth : viewHeight
        
        let headWidth = length * headWidth / 406
        let headHeignt = length * headHeight[headType] / 406
        let eyebrowWidth = length * eyebrowWidth / 406
        let eyebrowHeight = length * eyebrowHeight[eyebrowType] / 406
        let eyebrowBottomEdge = length * eyebrowBottomEdges[eyebrowType] / 406
        let mouthWidth = length * mouthWidth[mouthType] / 406
        let mouthHeight = length * mouthHeight[mouthType] / 406
        let mouthBottomEdge = length * mouthBottomEdges[mouthType] / 406
        let noseWidth = length * noseWidth[noseType] / 406
        let noseHeight = length * noseHeight[noseType] / 406
        let noseBottomEdge = length * noseBottomEdges[noseType] / 406
        let eyesWidth = length * eyesWidth[eyesType] / 406
        let eyesHeight = length * eyesHeight[eyesType] / 406
        let eyesBottomEdge = length * eyesBottomEdges[eyesType] / 406
        let glassesWidth = length * glassesWidth[glassesType] / 406
        let glassesHeight = length * glassesHeight[glassesType] / 406
        let glassesBottomEdge = length * glassesBottomEdges[glassesType] / 406
        
        let characterView = UIView(frame:CGRect(x: 0, y: 0, width: length, height: length))
        let characterViewCover = UIView(frame:CGRect(x: 0, y: 0, width: length, height: length))
        
        characterView.addSubview(bgButton)
        characterView.addSubview(headButton)
        characterView.addSubview(eyebrowButton)
        characterView.addSubview(mouthButton)
        characterView.addSubview(noseButton)
        characterView.addSubview(eyesButton)
        
        
        bgButton.setImage(UIImage(named: bgImages[bgType]), for: .normal)
        bgButton.translatesAutoresizingMaskIntoConstraints = false
        bgButton.heightAnchor.constraint(equalToConstant: length).isActive = true
        bgButton.widthAnchor.constraint(equalToConstant: length).isActive = true
        bgButton.centerXAnchor.constraint(equalTo: characterView.centerXAnchor).isActive = true
        bgButton.centerYAnchor.constraint(equalTo: characterView.centerYAnchor).isActive = true
        
        headButton.setImage(UIImage(named: headImages[headType]), for: .normal)
        headButton.translatesAutoresizingMaskIntoConstraints = false
        headButton.heightAnchor.constraint(equalToConstant: headHeignt).isActive = true
        headButton.widthAnchor.constraint(equalToConstant: headWidth).isActive = true
        headButton.centerXAnchor.constraint(equalTo: characterView.centerXAnchor).isActive = true
        headButton.bottomAnchor.constraint(equalTo: characterView.bottomAnchor).isActive = true
        
        eyebrowButton.setImage(UIImage(named: eyebrowImages[eyebrowType]), for: .normal)
        eyebrowButton.translatesAutoresizingMaskIntoConstraints = false
        eyebrowButton.heightAnchor.constraint(equalToConstant: eyebrowHeight).isActive = true
        eyebrowButton.widthAnchor.constraint(equalToConstant: eyebrowWidth).isActive = true
        eyebrowButton.centerXAnchor.constraint(equalTo: characterView.centerXAnchor).isActive = true
        characterView.bottomAnchor.constraint(equalTo: eyebrowButton.bottomAnchor,constant: eyebrowBottomEdge).isActive = true
        
        mouthButton.setImage(UIImage(named: mouthImages[mouthType]), for: .normal)
        mouthButton.translatesAutoresizingMaskIntoConstraints = false
        mouthButton.heightAnchor.constraint(equalToConstant: mouthHeight).isActive = true
        mouthButton.widthAnchor.constraint(equalToConstant: mouthWidth).isActive = true
        mouthButton.centerXAnchor.constraint(equalTo: characterView.centerXAnchor).isActive = true
        characterView.bottomAnchor.constraint(equalTo: mouthButton.bottomAnchor,constant: mouthBottomEdge).isActive = true
        
        noseButton.setImage(UIImage(named: noseImages[noseType]), for: .normal)
        noseButton.translatesAutoresizingMaskIntoConstraints = false
        noseButton.heightAnchor.constraint(equalToConstant: noseHeight).isActive = true
        noseButton.widthAnchor.constraint(equalToConstant: noseWidth).isActive = true
        noseButton.centerXAnchor.constraint(equalTo: characterView.centerXAnchor).isActive = true
        characterView.bottomAnchor.constraint(equalTo: noseButton.bottomAnchor,constant: noseBottomEdge).isActive = true
        
        eyesButton.setImage(UIImage(named: eyesImages[eyesType]), for: .normal)
        eyesButton.translatesAutoresizingMaskIntoConstraints = false
        eyesButton.heightAnchor.constraint(equalToConstant: eyesHeight).isActive = true
        eyesButton.widthAnchor.constraint(equalToConstant: eyesWidth).isActive = true
        eyesButton.centerXAnchor.constraint(equalTo: characterView.centerXAnchor).isActive = true
        characterView.bottomAnchor.constraint(equalTo: eyesButton.bottomAnchor,constant: eyesBottomEdge).isActive = true
        
        if(glassesType != 0){
            characterView.addSubview(glassesButton)
            glassesButton.setImage(UIImage(named: glassesImages[glassesType]), for: .normal)
            glassesButton.translatesAutoresizingMaskIntoConstraints = false
            glassesButton.heightAnchor.constraint(equalToConstant: glassesHeight).isActive = true
            glassesButton.widthAnchor.constraint(equalToConstant: glassesWidth).isActive = true
            glassesButton.centerXAnchor.constraint(equalTo: characterView.centerXAnchor).isActive = true
            characterView.bottomAnchor.constraint(equalTo: glassesButton.bottomAnchor,constant: glassesBottomEdge).isActive = true
        }
        
        self.addSubview(characterView)
        self.addSubview(characterViewCover)
    }
}

