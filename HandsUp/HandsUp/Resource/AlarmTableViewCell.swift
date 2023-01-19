//
//  AlarmTableViewCell.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/01/16.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    }

    @IBOutlet weak var timeLb_ATVC: UILabel!
    

    @IBOutlet weak var idLb_ATVC: UILabel!
    
    @IBOutlet weak var contentLb_ATVC: UILabel!
    
    @IBOutlet weak var characterImgV_ATVC: UIImageView!

    @IBOutlet weak var sendBtn_ATVC: UIButton!
    
    
    // MARK: Initialize
      override init(style: AlarmTableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
          

          
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
        self.sendBtn_ATVC.layer.masksToBounds = true
        self.sendBtn_ATVC.layer.cornerRadius  = CGFloat(roundf(Float(self.sendBtn_ATVC.frame.size.width/2.0)))
        self.sendBtn_ATVC.backgroundColor = UIColor(red: 0.31, green: 0.494, blue: 0.753, alpha: 1)
        

    }
    
    func setupLayout() {
        
        contentView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        //UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowRadius = 24
        contentView.layer.shadowOffset = CGSize(width: 0, height: 8)
        contentView.layer.masksToBounds = false

        contentView.layer.cornerRadius = 15
        
        contentView.layer.masksToBounds = false

        contentView.layer.backgroundColor = UIColor(named: "HandsUpRealWhite")?.cgColor
        

        //contentView.backgroundColor = .orange
        


    }

}
