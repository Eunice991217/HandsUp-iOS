//
//  RoundedShadow_UIButton.swift
//  HandsUp
//
//  Created by 황재상 on 2023/01/07.
//

import UIKit

class RoundedShadow_UIButton: UIButton {
    @IBInspectable override var cornerRadius: CGFloat{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable override var borderWidth: CGFloat{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable override var borderColor: UIColor{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.gray{
        didSet{
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 1.0 {
        didSet{
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize.zero {
        didSet{
            self.layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 24 {
        didSet{
            self.layer.shadowRadius = shadowRadius / UIScreen.main.scale
        }
    }
}
