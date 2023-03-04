//
//  FirtstListTableViewCell.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/25.
//

import UIKit
import SnapKit

class ListTableViewCell: UITableViewCell {

    static let id = "ListTableViewCell"
    
    lazy var img : UIImageView = { // 이미지 생성
       let imgView = UIImageView()
       imgView.translatesAutoresizingMaskIntoConstraints = false
       return imgView
    }()

    lazy var name: UILabel = { // 선언만했음. 메모리에는 아직 안올라가있음
        let label = UILabel()
        return label
    }()
    
    lazy var location: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var label1: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var label2: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var time: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var content: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        contentView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowRadius = 40
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentView.layer.masksToBounds = false
        contentView.layer.cornerRadius = 15

        contentView.layer.backgroundColor = UIColor(named: "HandsUpRealWhite")?.cgColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        contentView.addSubview(name) // 내용이 메모리에 올라갔음
        contentView.addSubview(location)
        contentView.addSubview(time)
        contentView.addSubview(content)
        contentView.addSubview(img)
        contentView.addSubview(label1)
        contentView.addSubview(label2)
        
//        content.lineBreakMode = .byWordWrapping
//        content.numberOfLines = 0

        name.snp.makeConstraints { make in
            make.leading.equalTo(img.snp.trailing).offset(27)
            make.top.equalTo(30)
            //make.trailing.equalTo(-5)
        }
        
        label1.snp.makeConstraints { make in
            make.leading.equalTo(name.snp.leading).offset(47)
            make.top.equalTo(30)
        }
        
        location.snp.makeConstraints { make in
            make.leading.equalTo(label1.snp.leading).offset(20)
            make.top.equalTo(30)
        }
        
        label2.snp.makeConstraints { make in
            make.leading.equalTo(location.snp.leading).offset(87)
            make.top.equalTo(30)
        }
        
        time.snp.makeConstraints { make in
            make.leading.equalTo(label2.snp.leading).offset(20)
            make.top.equalTo(30)
        }
        
        content.snp.makeConstraints { make in
            make.leading.equalTo(img.snp.trailing).offset(27)
            make.top.equalTo(60)
            make.trailing.equalTo(-15)
        }
        
        img.snp.makeConstraints { make in
            make.leading.top.equalTo(15)
            make.size.width.height.equalTo(75)
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
