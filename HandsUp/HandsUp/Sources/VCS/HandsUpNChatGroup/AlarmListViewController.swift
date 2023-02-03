//
//  AlarmListViewController.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/01/16.
//

import UIKit

class AlarmListViewController: UIViewController{
    
    
    @IBOutlet var alarmTableView_ALVC: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alarmTableView_ALVC.delegate = self
        alarmTableView_ALVC.dataSource = self
        alarmTableView_ALVC.rowHeight = 98
        
        alarmTableView_ALVC.backgroundColor = UIColor(named: "HandsUpBackGround")
        alarmTableView_ALVC.layer.masksToBounds = false
        alarmTableView_ALVC.clipsToBounds = false
        
        
    }

}

extension AlarmListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmTableViewCell", for: indexPath) as! AlarmTableViewCell
        cell.timeLb_ATVC.text = AlarmDataArr[indexPath.row].time
        
        cell.characterView_ATVC.setUserCharacter()
        cell.idLb_ATVC.text = "아래글에 " + AlarmDataArr[indexPath.row].name + "님이 관심있어요"
        cell.contentLb_ATVC.text = AlarmDataArr[indexPath.row].content
        
    
        return cell
    }
}
    

extension UIButton {
    var circleButton: Bool {
        set {
            
            if newValue {
                self.layer.cornerRadius = 0.5 * self.bounds.size.width
                
                self.backgroundColor = UIColor(red: 0.31, green: 0.494, blue: 0.753, alpha: 1)
            } else {
                self.layer.cornerRadius = 0
            }
        } get {
            return false
        }
    }
}
extension UIView {
    @IBInspectable var borderColor: UIColor {
        get {
            let color = self.layer.borderColor ?? UIColor.clear.cgColor
            return UIColor(cgColor: color)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        
        set {
            self.layer.borderWidth = newValue
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            self.layer.cornerRadius = newValue
        }
    }
}

extension UIView {
    func applyShadow(cornerRadius: CGFloat){
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 24
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 8)
        
        
    }
}

struct AlarmDataModel {
    let profileImage: UIImage?
    let name: String
    let time: String
    let content: String
}

let AlarmDataArr: [AlarmDataModel] = [
    AlarmDataModel(
            profileImage: UIImage(named: "characterExample2"),
            name: "차라나",
            time: "10분전",
            content: "1/31에 같이 점심 먹을 사람 구합니다!"

        ),
    AlarmDataModel(
            profileImage: UIImage(named: "characterExample3"),
            name: "천애플",
            time: "20분전",
            content: "아바타 4d 영화 같이 보실 분 있나요?!"
        )
]
