//
//  TabManListVC.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/16.
//

import UIKit
import Tabman
import Pageboy

class TabManListVC: TabmanViewController {
    
    @IBOutlet weak var TabManTabBar: UIView!
    
    var viewControllers: [ListVC] = []
    var curIndex: Int = 0
    let firstVC = ListFirstTabVC()
    let secondVC = ListSecondTabVC()
    let thirdVC = ListThirdTabVC()
    let fourthVC = ListFourthTabVC()
    let fifthVC = ListFifthTabVC()
    let sixthVC = ListSixthTabVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers.append(firstVC)
        viewControllers.append(secondVC)
        viewControllers.append(thirdVC)
        viewControllers.append(fourthVC)
        viewControllers.append(fifthVC)
        viewControllers.append(sixthVC)
        
        self.dataSource = self
        let bar = TMBar.ButtonBar()
        
        //탭바 레이아웃 설정
        bar.layout.transitionStyle = .snap
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .intrinsic
        //        .fit : indicator가 버튼크기로 설정됨
        bar.layout.interButtonSpacing = view.bounds.width / 8

        //배경색
        bar.backgroundView.style = .clear
                
        //간격설정
        bar.layout.contentInset = UIEdgeInsets(top: 5, left: 15, bottom: 0, right: 10)
                
        //버튼 글시 커스텀
        bar.buttons.customize{
            (button)
            in
            button.tintColor = UIColor(red: 0.776, green: 0.776, blue: 0.776, alpha: 1)
            button.selectedTintColor = UIColor(red: 0.937, green: 0.482, blue: 0.11, alpha: 1)
            button.font = UIFont(name:"Roboto-Bold", size: 15)!
        }
        //indicator
        bar.indicator.weight = .custom(value: 3)
        bar.indicator.overscrollBehavior = .bounce
        bar.indicator.tintColor = UIColor(red: 0.937, green: 0.482, blue: 0.11, alpha: 1)

        addBar(bar, dataSource: self, at:.top)
        // Do any additional setup after loading the view.
    }

}

extension TabManListVC: PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "#전체")
        case 1:
            return TMBarItem(title: "#Talk")
        case 2:
            return TMBarItem(title: "#밥")
        case 3:
            return TMBarItem(title: "#스터디")
        case 4:
            return TMBarItem(title: "#취미")
        case 5:
            return TMBarItem(title: "#여행")
        default:
            let title = "\(index)"
           return TMBarItem(title: title)
        }
    }

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        curIndex = index
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}


