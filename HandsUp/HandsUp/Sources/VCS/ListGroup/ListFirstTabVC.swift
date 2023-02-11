//
//  ViewController.swift
//  Test
//
//  Created by 김민경 on 2023/01/17.
//

import UIKit

class ListFirstTabVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Properties
    let myTableView: UITableView = UITableView()

    // MARK: ViewController override method
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.myTableView.dataSource = self
        self.myTableView.delegate = self

        self.myTableView.register(ListTableViewCell.self,
                              forCellReuseIdentifier: "ListTableViewCell")

        self.view.addSubview(self.myTableView)

        myTableView.separatorStyle = .none
        
        myTableView.backgroundColor = UIColor(red: 0.975, green: 0.975, blue: 0.975, alpha: 1)

        self.myTableView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addConstraint(NSLayoutConstraint(item: self.myTableView,
        attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top,
        multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.myTableView,
        attribute: .bottom, relatedBy: .equal, toItem: self.view,
        attribute: .bottom, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.myTableView,
        attribute: .leading, relatedBy: .equal, toItem: self.view,
        attribute: .leading, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.myTableView,
        attribute: .trailing, relatedBy: .equal, toItem: self.view,
        attribute: .trailing, multiplier: 1.0, constant: 0))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard? = UIStoryboard(name: "Main", bundle: Bundle.main)
                       
        // 스토리보드에서 지정해준 ViewController의 ID
        guard let myProfile = storyboard?.instantiateViewController(identifier: "MyProfile") else {return}
        myProfile.modalPresentationStyle = .overFullScreen
        self.present(myProfile, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyHomeList1Data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        cell.name.text = MyHomeList1Data[indexPath.row].name
        cell.name.font = UIFont(name: "Roboto-Regular", size: 14)
        cell.name.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
        
        cell.location.text = MyHomeList1Data[indexPath.row].location
        cell.location.font = UIFont(name: "Roboto-Regular", size: 14)
        cell.location.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
        
        cell.time.text = MyHomeList1Data[indexPath.row].time
        cell.time.font = UIFont(name: "Roboto-Regular", size: 14)
        cell.time.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)

        cell.content.text = MyHomeList1Data[indexPath.row].content
        cell.content.font = UIFont(name: "Roboto-Regular", size: 14)
        cell.content.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
        
        cell.label1.text = "|"
        cell.label1.font = UIFont(name: "Roboto-Regular", size: 14)
        cell.label1.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
        
        cell.label2.text = "|"
        cell.label2.font = UIFont(name: "Roboto-Regular", size: 14)
        cell.label2.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
        
        cell.img.image = MyHomeList1Data[indexPath.row].profileImage
        
        cell.selectionStyle = .none

        return cell
    }

}

struct MyHomeList1DataModel {
    let profileImage: UIImage?
    let name: String
    let location: String
    let time: String
    let content: String
}

let MyHomeList1Data: [MyHomeList1DataModel] = [
    MyHomeList1DataModel(
            profileImage: UIImage(named: "characterExample4"),
            name: "차라나",
            location: "경기도 성남시",
            time: "10분전",
            content: "제가 3시쯤에 수업이 끝날거 같은데 ..."
        ),
    MyHomeList1DataModel(
            profileImage: UIImage(named: "characterExample4"),
            name: "카리나",
            location: "경기도 성남시",
            time: "10분전",
            content: "제가 5시쯤에 수업이 끝날거 같은데 ..."
        )
]

