//
//  FirtstListTableViewCell.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/25.
//

import UIKit
import SnapKit

class FirtstListTableViewCell: UITableViewCell {

    static let id = "FirtstListTableViewCell"

    lazy var title: UILabel = { // 선언만했음. 메모리에는 아직 안올라가있음
        let label = UILabel()
        return label
    }()

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
        
        contentView.addSubview(title) // 타이틀은 메모리에 올라갔음
        // contentView.backgroundColor = .purple
        
        // 레이아웃 맞추기
        title.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
