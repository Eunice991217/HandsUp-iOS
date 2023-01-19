//
//  RoundableButton.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/01/08.
//

import UIKit

final class RoundableButton: UIButton { //원 형태의 uiview
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = min(self.frame.width, self.frame.height) / 2
    }
}
