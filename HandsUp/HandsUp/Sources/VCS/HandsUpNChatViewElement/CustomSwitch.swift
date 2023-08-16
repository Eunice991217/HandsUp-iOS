//
//  switchbtn.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/01/15.
//

import UIKit

@IBDesignable
public class CustomSwitch: UIControl {
    let labelWidth = 70.0
    
    // MARK: Public properties
    public var animationDelay: Double = 0
    public var animationSpriteWithDamping = CGFloat(0.7)
    public var initialSpringVelocity = CGFloat(0.5)
    public var animationOptions: UIView.AnimationOptions = [UIView.AnimationOptions.curveEaseOut, UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.allowUserInteraction]
    
    @IBInspectable public var isOn:Bool = true
    
    public var animationDuration: Double = 0.5
    
    @IBInspectable  public var padding: CGFloat = 1 {
        didSet {
            self.layoutSubviews()
        }
    }
    
    @IBInspectable  public var onTintColor: UIColor = UIColor(red: 0.937, green: 0.482, blue: 0.086, alpha: 1){
        didSet {
            self.setupUI()
        }
    }
    
    @IBInspectable public var offTintColor: UIColor = UIColor(red: 0.31, green: 0.494, blue: 0.753, alpha: 1){
        didSet {
            self.setupUI()
        }
    }
    
    @IBInspectable public override var cornerRadius: CGFloat {
        
        get {
            return self.privateCornerRadius
        }
        set {
            if newValue > 0.5 || newValue < 0.0 {
                privateCornerRadius = 0.5
            } else {
                privateCornerRadius = newValue
            }
        }
        
    }
    
    private var privateCornerRadius: CGFloat = 0.5 {
        didSet {
            self.layoutSubviews()
        }
    }
    
    // thumb properties
    @IBInspectable public var thumbTintColor: UIColor = UIColor.white {
        didSet {
            self.thumbView.backgroundColor = self.thumbTintColor
        }
    }
    
    @IBInspectable public var thumbCornerRadius: CGFloat {
        get {
            return self.privateThumbCornerRadius
        }
        set {
            if newValue > 0.5 || newValue < 0.0 {
                privateThumbCornerRadius = 0.5
            } else {
                privateThumbCornerRadius = newValue
            }
        }
        
    }
    
    private var privateThumbCornerRadius: CGFloat = 0.5 {
        didSet {
            self.layoutSubviews()
            
        }
    }
    
    @IBInspectable public var thumbSize: CGSize = CGSize.zero {
        didSet {
            self.layoutSubviews()
        }
    }
    
    @IBInspectable public var thumbImage:UIImage? = nil {
        didSet {
            guard let image = thumbImage else {
                return
            }
            thumbView.thumbImageView.image = image
        }
    }
    
    public var onImage:UIImage? {
        didSet {
            self.onImageView.image = onImage
            self.layoutSubviews()
            
        }
        
    }
    
    public var offImage:UIImage? {
        didSet {
            self.offImageView.image = offImage
            self.layoutSubviews()
        }
        
    }
    
    
    // dodati kasnije
    @IBInspectable public var thumbShadowColor: UIColor = UIColor.black {
        didSet {
            self.thumbView.layer.shadowColor = self.thumbShadowColor.cgColor
        }
    }
    
    @IBInspectable public var thumbShadowOffset: CGSize = CGSize(width: 0.75, height: 2) {
        didSet {
            self.thumbView.layer.shadowOffset = self.thumbShadowOffset
        }
    }
    
    @IBInspectable public var thumbShaddowRadius: CGFloat = 1.5 {
        didSet {
            self.thumbView.layer.shadowRadius = self.thumbShaddowRadius
        }
    }
    
    @IBInspectable public var thumbShaddowOppacity: Float = 0.4 {
        didSet {
            self.thumbView.layer.shadowOpacity = self.thumbShaddowOppacity
        }
    }
    
    // labels
    
    public var labelOff:UILabel = UILabel()
    public var labelOn:UILabel = UILabel()
    
    public var areLabelsShown: Bool = true {
        didSet {
            self.setupUI()
        }
    }
    
    public var thumbView = CustomThumbView(frame: CGRect.zero)
    public var onImageView = UIImageView(frame: CGRect.zero)
    public var offImageView = UIImageView(frame: CGRect.zero)
    public var onPoint = CGPoint.zero
    public var offPoint = CGPoint.zero
    public var isAnimating = false
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
}

// MARK: Private methods
extension CustomSwitch {
      func setupUI() {
        // clear self before configuration
        self.clear()
    
        self.clipsToBounds = false
        
        // configure thumb view
        self.thumbView.backgroundColor = self.thumbTintColor
        self.thumbView.isUserInteractionEnabled = false
        
        // dodati kasnije
        self.thumbView.layer.shadowColor = self.thumbShadowColor.cgColor
        self.thumbView.layer.shadowRadius = self.thumbShaddowRadius
        self.thumbView.layer.shadowOpacity = self.thumbShaddowOppacity
        self.thumbView.layer.shadowOffset = self.thumbShadowOffset
        self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
        
        self.addSubview(self.thumbView)
        self.addSubview(self.onImageView)
        self.addSubview(self.offImageView)
        
        self.setupLabels()
    }
    
    
    private func clear() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        
        self.animate()
        return true
    }
    
    func setOn(on:Bool, animated:Bool) {
        
        switch animated {
        case true:
            self.animate(on: on)
        case false:
            self.isOn = on
            self.setupViewsOnAction()
            self.completeAction()
        }
    }
    
    fileprivate func animate(on:Bool? = nil) {
        self.isOn = on ?? !self.isOn
        
        self.isAnimating = true
        let labelWidth = 70.0
        
        if(self.isOn){
            self.labelOn.text = "위치표시 O"
            self.labelOn.frame = CGRect(x: 0, y: 0, width: labelWidth, height: self.frame.height)
        }else{
            self.labelOn.text = "위치표시 X"
            self.labelOn.frame = CGRect(x: self.frame.width - labelWidth, y: 0, width: labelWidth, height: self.frame.height)
            
        }
        UIView.animate(withDuration: self.animationDuration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [UIView.AnimationOptions.curveEaseOut, UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.allowUserInteraction], animations: {
            self.setupViewsOnAction()
            
        }, completion: { _ in
            self.completeAction()
        })
    }
    
    private func setupViewsOnAction() {
        self.thumbView.frame.origin.x = self.isOn ? self.onPoint.x : self.offPoint.x
        self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
       
    }

    private func completeAction() {
        self.isAnimating = false
        self.sendActions(for: UIControl.Event.valueChanged)
    }
    
}

extension CustomSwitch {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if !self.isAnimating {
            self.layer.cornerRadius = self.bounds.size.height * self.cornerRadius
            self.backgroundColor = self.isOn ? self.onTintColor : self.offTintColor
            
            // thumb managment
            // get thumb size, if none set, use one from bounds
            let thumbSize = self.thumbSize != CGSize.zero ? self.thumbSize : CGSize(width: self.bounds.size.height - 2, height: self.bounds.height - 2)
            let yPostition = (self.bounds.size.height - thumbSize.height) / 2
            
            self.onPoint = CGPoint(x: self.bounds.size.width - thumbSize.width - self.padding, y: yPostition)
            self.offPoint = CGPoint(x: self.padding, y: yPostition)
            
            self.thumbView.frame = CGRect(origin: self.isOn ? self.onPoint : self.offPoint, size: thumbSize)
            self.thumbView.layer.cornerRadius = thumbSize.height * self.thumbCornerRadius
            
            
            //label frame
            if self.areLabelsShown {
                let labelWidth = 70.0
                self.labelOn.frame = self.isOn ? CGRect(x: 0, y: 0, width: labelWidth, height: self.frame.height) : CGRect(x: self.frame.width - labelWidth, y: 0, width: labelWidth, height: self.frame.height)
            }
            
            // on/off images
            //set to preserve aspect ratio of image in thumbView
            
            guard onImage != nil && offImage != nil else {
                return
            }
            
            let frameSize = thumbSize.width > thumbSize.height ? thumbSize.height * 0.7 : thumbSize.width * 0.7
            
            let onOffImageSize = CGSize(width: frameSize, height: frameSize)
            
            
            self.onImageView.frame.size = onOffImageSize
            self.offImageView.frame.size = onOffImageSize
            
            self.onImageView.center = CGPoint(x: self.onPoint.x + self.thumbView.frame.size.width / 2, y: self.thumbView.center.y)
            self.offImageView.center = CGPoint(x: self.offPoint.x + self.thumbView.frame.size.width / 2, y: self.thumbView.center.y)
            
            
            self.onImageView.alpha = self.isOn ? 1.0 : 0.0
            self.offImageView.alpha = self.isOn ? 0.0 : 1.0
            
        }
    }
}


//Mark: Labels frame
extension CustomSwitch {
    
    fileprivate func setupLabels() {
        guard self.areLabelsShown else {
            self.labelOn.alpha = 0
            return
            
        }
        
        self.labelOn.alpha = 1
        
        let labelWidth = 70.0
 
        self.labelOn.font =  UIFont(name: "Roboto-Medium", size: 12)
        self.labelOn.textColor = UIColor.white
        

        self.labelOn.text = self.isOn ? "위치표시 O" : "위치표시 X"
        self.labelOn.frame = self.isOn ? CGRect(x: 0, y: 0, width: labelWidth, height: self.frame.height) : CGRect(x: self.frame.width - labelWidth, y: 0, width: labelWidth, height: self.frame.height)
        
        print("frame x 좌표: \(self.labelOn.frame)")
       
        self.labelOn.sizeToFit()
        self.labelOn.textAlignment = .center
        
        self.insertSubview(self.labelOn, belowSubview: self.thumbView)
    }
    
}

//Mark: Animating on/off images
extension CustomSwitch {
    
    fileprivate func setOnOffImageFrame() {
        guard onImage != nil && offImage != nil else {
            return
        }
        
        self.onImageView.center.x = self.isOn ? self.onPoint.x + self.thumbView.frame.size.width / 2 : self.frame.width
        self.offImageView.center.x = !self.isOn ? self.offPoint.x + self.thumbView.frame.size.width / 2 : 0
        self.onImageView.alpha = self.isOn ? 1.0 : 0.0
        self.offImageView.alpha = self.isOn ? 0.0 : 1.0
    }
}


