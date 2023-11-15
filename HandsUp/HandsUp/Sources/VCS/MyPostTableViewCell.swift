//
//  MyPostTableViewCell.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/14.
//

import UIKit

class MyPostTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var MyPostTableContentView: UIView!
   
    @IBOutlet var MyPostTableViewCellImage: Character_UIView!
    @IBOutlet weak var MyPostTableViewCellName: UILabel!
    @IBOutlet weak var MyPostTableViewCellLoaction: UILabel!
    @IBOutlet weak var MyPostTableViewCellTime: UILabel!
    @IBOutlet weak var MyPostTableViewCellContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10))
        contentView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowRadius = 40
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentView.layer.masksToBounds = false
        contentView.layer.cornerRadius = 15

        contentView.layer.backgroundColor = UIColor(named: "HandsUpRealWhite")?.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
