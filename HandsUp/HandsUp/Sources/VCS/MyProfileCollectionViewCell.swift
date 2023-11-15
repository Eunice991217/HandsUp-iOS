//
//  MyProfileCollectionViewCell.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/31.
//

import UIKit

class MyProfileCollectionViewCell: UICollectionViewCell {
    
    
    
    
    @IBOutlet var Card: UIView!
    
    @IBOutlet var tagView: UIView!
    @IBOutlet var schoolView: UIView!
    
    @IBOutlet var largeName: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var smallName: UILabel!
    
    @IBOutlet var profileImage: Character_UIView!
    
    @IBOutlet var content: UILabel!
    
    
    @IBOutlet var school: UILabel!
//    @IBOutlet var tagType: UILabel!
    
    @IBOutlet var tagType: UILabel!
    
    
    @IBOutlet var heart: UIButton!
    @IBOutlet var send: UIButton!
    @IBOutlet var cancel: UIButton!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        Card.cornerRadius = 30
        tagView.cornerRadius = 15
        schoolView.cornerRadius = 15
        
    }
    
}
