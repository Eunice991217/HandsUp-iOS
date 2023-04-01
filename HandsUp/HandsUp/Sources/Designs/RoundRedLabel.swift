//
//  RoundRedLabel.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/03/25.
//

import UIKit

class RoundRedLabel: UILabel{
    override var alpha: CGFloat{
        didSet{
            if(UserDefaults.standard.object(forKey: "NotReadMsgCount") == nil){
                self.alpha = 0
            }
            else{
                if( UserDefaults.standard.integer(forKey: "NotReadMsgCount") == 0){
                    self.alpha = 0
                }else{
                    self.alpha = 1
                }
            }
            
        }
    }
}
