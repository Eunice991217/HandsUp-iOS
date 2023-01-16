////
////  HomeListTableViewCell.swift
////  HandsUp
////
////  Created by 김민경 on 2023/01/16.
////
//
//import UIKit
//
//class HomeListTableViewCell: UITableViewCell {
//
//
//    @IBOutlet weak var HomeTableContentView: UIView!
//
//    @IBOutlet weak var HomeTableViewCellImage: UIImageView!
//    @IBOutlet weak var HomeTableViewCellName: UILabel!
//    @IBOutlet weak var HomeTableViewCellLocation: UILabel!
//    @IBOutlet weak var HomeTableViewCellContent: UILabel!
//    @IBOutlet weak var HomeTableViewCellTime: UILabel!
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        HomeTableContentView.layer.cornerRadius = 20
//        HomeTableContentView.backgroundColor = UIColor.white
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
//        // Configure the view for the selected state
//    }
//
//}
