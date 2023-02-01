//
//  MyProfileCollectionViewCell.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/31.
//

import UIKit

class MyProfileCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var CardView: UIView!
    
    
    @IBOutlet var MyProfileCellContent: UILabel!
    
    @IBOutlet var MyProfileCellLargeName: UILabel!
    @IBOutlet var MyProfileSmallName: UILabel!
    @IBOutlet var MyProfileCellLocation: UILabel!
    @IBOutlet var MyProfileCellTime: UILabel!
    @IBOutlet var MyProfileCellImage: UIImageView!
    
    
    @IBOutlet var MyProfileTag: UIView!
    @IBOutlet var MyProfileCellTag: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()

        // MyProfileTag.layer.cornerRadius = 5
    }
    
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
