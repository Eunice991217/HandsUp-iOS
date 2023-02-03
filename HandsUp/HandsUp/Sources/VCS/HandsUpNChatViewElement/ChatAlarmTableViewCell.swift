//
//  ChatAlarmTableViewCell.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/01/17.
//

import UIKit

class ChatAlarmTableViewCell: UITableViewCell {

    
    @IBOutlet weak var characterView_CATVC: Character_UIView!
    
    @IBOutlet weak var idLb_CATVC: UILabel!
    
    @IBOutlet weak var contentLb_CATVC: UILabel!
    
    @IBOutlet weak var timeLb_CATVC: UILabel!
    
    @IBOutlet weak var countLb_CATVX: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            //self.contentView.layer.borderWidth = 2
           // self.contentView.layer.borderColor = UIColor.blue.cgColor
        } else {
           // self.contentView.layer.borderWidth = 1
           // self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
      
     
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.makeItCircle()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 10, right: 15))
        
        self.setupLayout()
    }

    func makeItCircle() {
        self.countLb_CATVX.layer.masksToBounds = true
        self.countLb_CATVX.layer.cornerRadius  = CGFloat(roundf(Float(self.countLb_CATVX.frame.size.width/2.0)))

    }
    
    func setupLayout() {
        
        contentView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        //UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowRadius = 24
        contentView.layer.shadowOffset = CGSize(width: 0, height: 8)
        contentView.layer.masksToBounds = false
        contentView.clipsToBounds = false

        contentView.layer.cornerRadius = 15
    

        contentView.layer.backgroundColor = UIColor(named: "HandsUpRealWhite")?.cgColor
        

        //contentView.backgroundColor = .orange
        


    }

}
