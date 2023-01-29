//
//  MyChatTableViewCell.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/01/18.
//

import UIKit

protocol TableViewCellDelegate:class {
    //func updateTextViewHeight(_ cell:TableViewCell,_ textView:UITextView)
}

class MyChatTableViewCell: UITableViewCell, UITextViewDelegate {
    
    weak var delegate: TableViewCellDelegate?

   @IBOutlet weak var contentTV_MCTVC: UITextView!
    
    @IBOutlet weak var timeLb_MCTVC: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentTV_MCTVC.isEditable = false
        //setTextView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    
    func setTextView() {
        contentTV_MCTVC.delegate = self
        contentTV_MCTVC.isScrollEnabled = false
        contentTV_MCTVC.sizeToFit()
        }
  

    
}
