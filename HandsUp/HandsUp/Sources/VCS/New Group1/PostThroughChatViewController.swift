//
//  postThroughChatViewController.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/01/26.
//

import UIKit

class PostThroughChatViewController: UIViewController {

    
    @IBOutlet weak var contentTextView_PTCVC: UITextView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 0.642, green: 0.642, blue: 0.642, alpha: 0.8)
        contentTextView_PTCVC.contentInset = .init(top: 14, left: 14, bottom: 14, right: 14)
       // setupBlurEffect()
        // Do any additional setup after loading the view.
    }
    
    func setupBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = view.frame
        view.addSubview(visualEffectView)
    }
    
    @IBAction func cancelBtnDidTap(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    

}
