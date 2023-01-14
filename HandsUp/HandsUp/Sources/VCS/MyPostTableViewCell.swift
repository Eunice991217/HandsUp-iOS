//
//  MyPostTableViewCell.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/14.
//

import UIKit

class MyPostTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var MyPostTableContentView: UIView!
    @IBOutlet weak var MyPostTableViewCellImage: UIImageView!
    @IBOutlet weak var MyPostTableViewCellName: UILabel!
    @IBOutlet weak var MyPostTableViewCellLoaction: UILabel!
    @IBOutlet weak var MyPostTableViewCellTime: UILabel!
    @IBOutlet weak var MyPostTableViewCellContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //MyPostTableViewCellImage.layer.cornerRadius = 63
        MyPostTableContentView.layer.cornerRadius = 20
        MyPostTableContentView.backgroundColor = UIColor.white
        
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
