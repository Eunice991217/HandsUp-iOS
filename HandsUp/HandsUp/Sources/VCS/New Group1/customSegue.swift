//
//  customSegue.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/01/28.
//

import UIKit

class customSegue: UIStoryboardSegue {
    
    override func perform() {
        let srcUVC = self.source
        let destUVC = self.destination
        
        UIView.transition(from: srcUVC.view, to: destUVC.view, duration: 0.2, options: .transitionFlipFromRight)
    }

}
