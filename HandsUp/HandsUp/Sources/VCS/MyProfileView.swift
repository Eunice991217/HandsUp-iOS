import UIKit
import SwiftUI

class MyProfileView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        let postCollectionViewCell = UIHostingController(rootView: PostCollectionviewCell())
        addChild(postCollectionViewCell)
        postCollectionViewCell.view.frame = view.bounds
        view.addSubview(postCollectionViewCell.view)
        postCollectionViewCell.didMove(toParent: self)
    }
    
    func setupView() {
        // 6. add blur view and send it to back
        view.addSubview(blurredView)
        view.sendSubviewToBack(blurredView)
    }
    
    lazy var blurredView: UIView = {
        // 1. create container view
        let containerView = UIView()
        // 2. create custom blur view
        let blurEffect = UIBlurEffect(style: .light)
        let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.4)
        customBlurEffectView.frame = self.view.bounds
        // 3. create semi-transparent black view
        let dimmedView = UIView()
        dimmedView.backgroundColor = .black.withAlphaComponent(0.3)
        dimmedView.frame = self.view.bounds
        
        // 4. add both as subviews
        containerView.addSubview(customBlurEffectView)
        containerView.addSubview(dimmedView)
        return containerView
    }()
}


