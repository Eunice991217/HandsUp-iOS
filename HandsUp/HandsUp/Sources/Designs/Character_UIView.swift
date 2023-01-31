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
    var shadow1: UIButton = UIButton()
    var shadow2: UIButton = UIButton()
    var shadow3: UIButton = UIButton()
    let eyesImages:[String] = ["characterEyes1", "characterEyes2", "characterEyes3", "characterEyes4"]
    let eyebrowImages:[String] = ["characterEyebrow1", "characterEyebrow2", "characterEyebrow3"]
    let noseImages:[String] = ["characterNose1", "characterNose2", "characterNose3", "characterNose4"]
    let mouthImages:[String] = ["characterMouth1", "characterMouth2", "characterMouth3", "characterMouth4"]
    let glassesImages:[String] = ["", "characterGlasses1", "characterGlasses2", "characterSunglasses"]
    let headImages:[String] = ["characterHeadCurly", "characterHeadShort", "characterHeadBald", "characterHeadBeanie", "characterHeadPomade"]
    let bgImages:[String] = ["CharacterBackgroundOrange", "CharacterBackgroundBlue"]
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
    let headHeight:[CGFloat] = [385, 350, 314, 341, 372]
    let shadowOffsetHeightArray:[Int] = [ 103, 58, 26, 6]
    let shadowRadiusArray:[CGFloat] = [ 41, 35, 26, 14]
    let shadowOpacityArray:[Float] = [ 0.01, 0.05, 0.09, 0.1]
    var constraintsArray: [NSLayoutConstraint] = []
    
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
    
    func setAll(componentArray: [Int]){
        self.bgType = componentArray[0]
        self.headType = componentArray[1]
        self.eyebrowType = componentArray[2]
        self.mouthType = componentArray[3]
        self.noseType = componentArray[4]
        self.eyesType = componentArray[5]
        self.glassesType = componentArray[6]
    }
    
    func setAll(BgType : Int, HeadType : Int, EyebrowType : Int, MouthType : Int, NoseType : Int, EyesType : Int, GlassesType : Int){
        self.bgType = BgType
        self.headType = HeadType
        self.eyebrowType = EyebrowType
        self.mouthType = MouthType
        self.noseType = NoseType
        self.eyesType = EyesType
        self.glassesType = GlassesType
        
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
    
    func setCharacter(){
        for view in self.subviews {
            view.removeFromSuperview()
        }
        self.backgroundColor = .clear
        eyesButton = UIButton()
        eyebrowButton = UIButton()
        noseButton = UIButton()
        mouthButton = UIButton()
        glassesButton = UIButton()
        headButton = UIButton()
        bgButton = UIButton()
        shadow1 = UIButton()
        shadow2 = UIButton()
        shadow3 = UIButton()
        
        let shadowArray: [UIButton] = [shadow1, shadow2, shadow3, bgButton]
        
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
        
        shadowArray.forEach {
            characterView.addSubview($0)
        }
        characterView.addSubview(headButton)
        characterView.addSubview(eyebrowButton)
        characterView.addSubview(mouthButton)
        characterView.addSubview(noseButton)
        characterView.addSubview(eyesButton)
        characterView.addSubview(glassesButton)
        
        var indexRow = 0
        shadowArray.forEach {
            $0.setImage(UIImage(named: bgImages[bgType]), for: .normal)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.heightAnchor.constraint(equalToConstant: length).isActive = true
            $0.widthAnchor.constraint(equalToConstant: length).isActive = true
            $0.centerXAnchor.constraint(equalTo: characterView.centerXAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: characterView.centerYAnchor).isActive = true
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowRadius = shadowRadiusArray[indexRow] / UIScreen.main.scale
            $0.layer.shadowOffset = CGSize(width: 0, height: shadowOffsetHeightArray[indexRow])
            $0.layer.shadowOpacity = shadowOpacityArray[indexRow]
            indexRow += 1
        }
        
        headButton.setImage(UIImage(named: headImages[headType]), for: .normal)
        headButton.translatesAutoresizingMaskIntoConstraints = false
        eyebrowButton.setImage(UIImage(named: eyebrowImages[eyebrowType]), for: .normal)
        eyebrowButton.translatesAutoresizingMaskIntoConstraints = false
        mouthButton.setImage(UIImage(named: mouthImages[mouthType]), for: .normal)
        mouthButton.translatesAutoresizingMaskIntoConstraints = false
        noseButton.setImage(UIImage(named: noseImages[noseType]), for: .normal)
        noseButton.translatesAutoresizingMaskIntoConstraints = false
        eyesButton.setImage(UIImage(named: eyesImages[eyesType]), for: .normal)
        eyesButton.translatesAutoresizingMaskIntoConstraints = false
        if(glassesType != 0){
            glassesButton.setImage(UIImage(named: glassesImages[glassesType]), for: .normal)
        }
        glassesButton.translatesAutoresizingMaskIntoConstraints = false
        
        constraintsArray.forEach {
            $0.isActive = false
        }
        
        constraintsArray = [ headButton.heightAnchor.constraint(equalToConstant: headHeignt)
                             , headButton.widthAnchor.constraint(equalToConstant: headWidth),
                             headButton.centerXAnchor.constraint(equalTo: characterView.centerXAnchor),
                             headButton.bottomAnchor.constraint(equalTo: characterView.bottomAnchor,constant: 1),
                             
                             eyebrowButton.heightAnchor.constraint(equalToConstant: eyebrowHeight),
                             eyebrowButton.widthAnchor.constraint(equalToConstant: eyebrowWidth),
                             eyebrowButton.centerXAnchor.constraint(equalTo: characterView.centerXAnchor),
                             characterView.bottomAnchor.constraint(equalTo: eyebrowButton.bottomAnchor,constant: eyebrowBottomEdge),
                             
                             mouthButton.heightAnchor.constraint(equalToConstant: mouthHeight),
                             mouthButton.widthAnchor.constraint(equalToConstant: mouthWidth),
                             mouthButton.centerXAnchor.constraint(equalTo: characterView.centerXAnchor),
                             characterView.bottomAnchor.constraint(equalTo: mouthButton.bottomAnchor,constant: mouthBottomEdge),
                             
                             noseButton.heightAnchor.constraint(equalToConstant: noseHeight),
                             noseButton.widthAnchor.constraint(equalToConstant: noseWidth),
                             noseButton.centerXAnchor.constraint(equalTo: characterView.centerXAnchor),
                             characterView.bottomAnchor.constraint(equalTo: noseButton.bottomAnchor,constant: noseBottomEdge),
                             
                             eyesButton.heightAnchor.constraint(equalToConstant: eyesHeight),
                             eyesButton.widthAnchor.constraint(equalToConstant: eyesWidth),
                             eyesButton.centerXAnchor.constraint(equalTo: characterView.centerXAnchor),
                             characterView.bottomAnchor.constraint(equalTo: eyesButton.bottomAnchor,constant: eyesBottomEdge),
                             
                             glassesButton.heightAnchor.constraint(equalToConstant: glassesHeight),
                             glassesButton.widthAnchor.constraint(equalToConstant: glassesWidth),
                             glassesButton.centerXAnchor.constraint(equalTo: characterView.centerXAnchor),
                             characterView.bottomAnchor.constraint(equalTo: glassesButton.bottomAnchor,constant: glassesBottomEdge)
        ]
        
        constraintsArray.forEach {
            $0.isActive = true
        }
        
        self.addSubview(characterView)
        self.addSubview(characterViewCover)
    }
    
    func setCharacter(componentArray: [Int]){
        setAll(componentArray: componentArray)
        setCharacter()
    }
    
    func setUserCharacter(){
        if true{
            self.bgType = UserDefaults.standard.integer(forKey: "backgroundColor")
            self.headType = UserDefaults.standard.integer(forKey: "hair")
            self.eyebrowType = UserDefaults.standard.integer(forKey: "eyeBrow")
            self.mouthType = UserDefaults.standard.integer(forKey: "mouth")
            self.noseType = UserDefaults.standard.integer(forKey: "nose")
            self.eyesType = UserDefaults.standard.integer(forKey: "eye")
            self.glassesType = UserDefaults.standard.integer(forKey: "glasses")
        }
        setCharacter()
    }
    
    func setCharacterOnly(){
        for view in self.subviews {
            view.removeFromSuperview()
        }
        self.backgroundColor = .clear
        eyesButton = UIButton()
        eyebrowButton = UIButton()
        noseButton = UIButton()
        mouthButton = UIButton()
        glassesButton = UIButton()
        headButton = UIButton()
        
        let length = self.frame.width
        
        let headWidth = length * headWidth / 288
        let headHeignt = length * headHeight[headType] / 288
        let eyebrowWidth = length * eyebrowWidth / 288
        let eyebrowHeight = length * eyebrowHeight[eyebrowType] / 288
        let eyebrowBottomEdge = length * eyebrowBottomEdges[eyebrowType] / 288
        let mouthWidth = length * mouthWidth[mouthType] / 288
        let mouthHeight = length * mouthHeight[mouthType] / 288
        let mouthBottomEdge = length * mouthBottomEdges[mouthType] / 288
        let noseWidth = length * noseWidth[noseType] / 288
        let noseHeight = length * noseHeight[noseType] / 288
        let noseBottomEdge = length * noseBottomEdges[noseType] / 288
        let eyesWidth = length * eyesWidth[eyesType] / 288
        let eyesHeight = length * eyesHeight[eyesType] / 288
        
        let eyesBottomEdge = length * eyesBottomEdges[eyesType] / 288
        let glassesWidth = length * glassesWidth[glassesType] / 288
        let glassesHeight = length * glassesHeight[glassesType] / 288
        let glassesBottomEdge = length * glassesBottomEdges[glassesType] / 288
        
        let characterView = UIView(frame:CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        let characterViewCover = UIView(frame:CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        
        
        characterView.addSubview(headButton)
        characterView.addSubview(eyebrowButton)
        characterView.addSubview(mouthButton)
        characterView.addSubview(noseButton)
        characterView.addSubview(eyesButton)
        characterView.addSubview(glassesButton)
        
        headButton.setImage(UIImage(named: headImages[headType]), for: .normal)
        headButton.translatesAutoresizingMaskIntoConstraints = false
        eyebrowButton.setImage(UIImage(named: eyebrowImages[eyebrowType]), for: .normal)
        eyebrowButton.translatesAutoresizingMaskIntoConstraints = false
        mouthButton.setImage(UIImage(named: mouthImages[mouthType]), for: .normal)
        mouthButton.translatesAutoresizingMaskIntoConstraints = false
        noseButton.setImage(UIImage(named: noseImages[noseType]), for: .normal)
        noseButton.translatesAutoresizingMaskIntoConstraints = false
        eyesButton.setImage(UIImage(named: eyesImages[eyesType]), for: .normal)
        eyesButton.translatesAutoresizingMaskIntoConstraints = false
        if(glassesType != 0){
            glassesButton.setImage(UIImage(named: glassesImages[glassesType]), for: .normal)
        }
        glassesButton.translatesAutoresizingMaskIntoConstraints = false
        
        constraintsArray.forEach {
            $0.isActive = false
        }
        
        constraintsArray = [ headButton.heightAnchor.constraint(equalToConstant: headHeignt)
                             , headButton.widthAnchor.constraint(equalToConstant: headWidth),
                             headButton.centerXAnchor.constraint(equalTo: characterView.centerXAnchor),
                             headButton.bottomAnchor.constraint(equalTo: characterView.bottomAnchor),
                             
                             eyebrowButton.heightAnchor.constraint(equalToConstant: eyebrowHeight),
                             eyebrowButton.widthAnchor.constraint(equalToConstant: eyebrowWidth),
                             eyebrowButton.centerXAnchor.constraint(equalTo: characterView.centerXAnchor),
                             characterView.bottomAnchor.constraint(equalTo: eyebrowButton.bottomAnchor,constant: eyebrowBottomEdge),
                             
                             mouthButton.heightAnchor.constraint(equalToConstant: mouthHeight),
                             mouthButton.widthAnchor.constraint(equalToConstant: mouthWidth),
                             mouthButton.centerXAnchor.constraint(equalTo: characterView.centerXAnchor),
                             characterView.bottomAnchor.constraint(equalTo: mouthButton.bottomAnchor,constant: mouthBottomEdge),
                             
                             noseButton.heightAnchor.constraint(equalToConstant: noseHeight),
                             noseButton.widthAnchor.constraint(equalToConstant: noseWidth),
                             noseButton.centerXAnchor.constraint(equalTo: characterView.centerXAnchor),
                             characterView.bottomAnchor.constraint(equalTo: noseButton.bottomAnchor,constant: noseBottomEdge),
                             
                             eyesButton.heightAnchor.constraint(equalToConstant: eyesHeight),
                             eyesButton.widthAnchor.constraint(equalToConstant: eyesWidth),
                             eyesButton.centerXAnchor.constraint(equalTo: characterView.centerXAnchor),
                             characterView.bottomAnchor.constraint(equalTo: eyesButton.bottomAnchor,constant: eyesBottomEdge),
                             
                             glassesButton.heightAnchor.constraint(equalToConstant: glassesHeight),
                             glassesButton.widthAnchor.constraint(equalToConstant: glassesWidth),
                             glassesButton.centerXAnchor.constraint(equalTo: characterView.centerXAnchor),
                             characterView.bottomAnchor.constraint(equalTo: glassesButton.bottomAnchor,constant: glassesBottomEdge)
        ]
        
        constraintsArray.forEach {
            $0.isActive = true
        }
        
        self.addSubview(characterView)
        self.addSubview(characterViewCover)
    }
}

extension UIView {
  func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
