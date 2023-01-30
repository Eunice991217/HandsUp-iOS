//
//  ServerError_ViewController.swift
//  HandsUp
//
//  Created by 황재상 on 2023/01/31.
//

import UIKit

class ServerError_ViewController: UIViewController {

    @IBOutlet weak var character_SE: Character_UIView!
    @IBOutlet weak var title_SE: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        character_SE.setCharacter(componentArray: [1, 2, 0, 0, 0, 3, 2])
        title_SE.text = "네트워크 연결상태가\n좋지 않습니다."
        let attributedStr = NSMutableAttributedString(string: title_SE.text!)
        attributedStr.addAttribute(.foregroundColor, value: UIColor(named:"HandsUpRed")!, range: (title_SE.text! as NSString).range(of: "연결상태"))
        title_SE.attributedText = attributedStr
    }
}
