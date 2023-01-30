//
//  FirtstListTableViewCell.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/25.
//

import UIKit
import SnapKit

class FifthListTableViewCell: UITableViewCell {

    static let id = "FifthListTableViewCell"
    
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

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left:10, bottom: 5, right: 10))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        content.lineBreakMode = .byWordWrapping
        content.numberOfLines = 0
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //contentView.addSubview(label)
        contentView.addSubview(name) // 내용이 메모리에 올라갔음
        contentView.addSubview(location)
        contentView.addSubview(time)
        contentView.addSubview(content)
        contentView.addSubview(img)
        contentView.backgroundColor = .white
        
        contentView.layer.shadowOffset = CGSize(width: 10, height: 10)
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowRadius = 30
        
        contentView.layer.cornerRadius = 20

        name.snp.makeConstraints { make in
            make.leading.equalTo(img.snp.trailing).offset(27)
            make.top.equalTo(30)
            //make.trailing.equalTo(-5)
        }
        
        location.snp.makeConstraints { make in
            make.leading.equalTo(name.snp.leading).offset(57)
            make.top.equalTo(30)
        }
        
        time.snp.makeConstraints { make in
            make.leading.equalTo(location.snp.leading).offset(105)
            make.top.equalTo(30)
        }
        
        content.snp.makeConstraints { make in
            make.leading.equalTo(img.snp.trailing).offset(27)
            make.top.equalTo(60)
            // make.trailing.equalTo(-5)
        }
        
        img.snp.makeConstraints { make in
            make.leading.top.equalTo(20)
            make.size.width.height.equalTo(75)
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
