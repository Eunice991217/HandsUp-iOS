import UIKit

class MultiLayerShadow_UIButton: UIButton{
    var layer1 = CALayer(), layer2 = CALayer(), layer3 = CALayer(), layer4 = CALayer(), layer5 = CALayer(), layer6 = CALayer()
    func shadow6Layer(){
        [layer1, layer2, layer3, layer4, layer5, layer6].forEach {
            $0.masksToBounds = false
            $0.frame = self.layer.bounds
            $0.shadowColor = UIColor.black.cgColor
            self.layer.insertSublayer($0, at: 0)
        }
        
        layer1.shadowRadius = 45 / UIScreen.main.scale
        layer2.shadowRadius = 41 / UIScreen.main.scale
        layer3.shadowRadius = 35 / UIScreen.main.scale
        layer4.shadowRadius = 26 / UIScreen.main.scale
        layer5.shadowRadius = 14 / UIScreen.main.scale
        layer6.shadowRadius = 0
        
        layer1.shadowOffset = CGSize(width: 0, height: 160)
        layer2.shadowOffset = CGSize(width: 0, height: 103)
        layer3.shadowOffset = CGSize(width: 0, height: 58)
        layer4.shadowOffset = CGSize(width: 0, height: 26)
        layer5.shadowOffset = CGSize(width: 0, height: 6)
        layer6.shadowOffset = CGSize(width: 0, height: 0)
        
        layer1.shadowOpacity = 0
        layer2.shadowOpacity = 0.21
        layer3.shadowOpacity = 0.05
        layer4.shadowOpacity = 0.09
        layer5.shadowOpacity = 0.1
        layer6.shadowOpacity = 0.1
    }
}
