//
//  AlarmListViewController.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/01/16.
//

import UIKit

class AlarmListViewController: UIViewController{
    
    
    @IBOutlet var alarmTableView_ALVC: UITableView!
    
    let imgArr_ALVC = ["characterExample3", "characterExample2", "characterExample3", "characterExample3", "characterExample2", "characterExample3","characterExample3", "characterExample2", "characterExample3"]
    
    let timeLbArr_ALVC = ["3분 전", "10분 전", "30분 전", "33분 전", "40분 전", "50분 전","1시간 전", "2시간 전", "하루 전"]
    
    let idLbArr_ALVC = ["차라나", "김라나", "천라나", "차애플", "김애플", "천애플","차안드", "김안드", "천안드"]
    
    let contentArr_ALVC = ["아아아아아아", "이이잉이이잉이이", "고고고고고고고","아아아아아아", "이이잉이이잉이이", "고고고고고고고","아아아아아아", "이이잉이이잉이이", "고고고고고고고"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alarmTableView_ALVC.delegate = self
        alarmTableView_ALVC.dataSource = self
        alarmTableView_ALVC.rowHeight = 98
        
    
    }


}

extension AlarmListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmTableViewCell", for: indexPath) as! AlarmTableViewCell
        cell.characterImgV_ATVC.image = UIImage(named: imgArr_ALVC[indexPath.row])
        cell.timeLb_ATVC.text = timeLbArr_ALVC[indexPath.row]
        cell.idLb_ATVC.text = "아래글에 " + idLbArr_ALVC[indexPath.row] + "님이 관심있어요"
        cell.contentLb_ATVC.text = contentArr_ALVC[indexPath.row]
        
    
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
