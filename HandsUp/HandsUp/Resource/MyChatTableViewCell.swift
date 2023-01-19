//
//  MyChatTableViewCell.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/01/18.
//

import UIKit

class MyChatTableViewCell: UITableViewCell{

    @IBOutlet weak var contentTV_MCTVC: UITextView!
    
    @IBOutlet weak var timeLb_MCTVC: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
        contentTV_MCTVC.textContainerInset = .zero
        
        textViewDidChange(contentTV_MCTVC)
        
        //contentView.backgroundColor = .orange
        


    }
    
    func textViewDidChange(_ textView: UITextView) {
        let newSize = textView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        textView.frame = CGRect(origin: textView.frame.origin, size: newSize)
        
        
    }
    
}
