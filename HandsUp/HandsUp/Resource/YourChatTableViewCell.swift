//
//  YourChatTableViewCell.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/01/18.
//

import UIKit

class YourChatTableViewCell: UITableViewCell {

    @IBOutlet weak var contentTV_YCTVC: UITextView!
    
    
    @IBOutlet weak var timeLb_YCTVC: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentTV_YCTVC.isEditable = false
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
      
     
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        
        self.setupLayout()
    }
    
    func setupLayout() {
        contentTV_YCTVC.textContainerInset = .zero
        contentTV_YCTVC.sizeToFit()

    }
}
