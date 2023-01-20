//
//  EnableButtonScroll.swift
//  HandsUp
//
//  Created by 황재상 on 2023/01/20.
//

import UIKit

class EnableButtonScroll: UIScrollView {
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIButton {
          return true
        }
        return super.touchesShouldCancel(in: view)
      }
}
