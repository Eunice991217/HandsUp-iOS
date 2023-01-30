//
//  ViewController.swift
//  Test
//
//  Created by 김민경 on 2023/01/17.
//

import UIKit

class ListFifthTabVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
      // print(names[indexPath.row])
        //tableView.cellForRow(at: indexPath)?.contentView.backgroundColor = .blue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyHomeList5Data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
//        switch indexPath.row {
//        case 0:
//            return 100
//        case 1:
//            return 200
//        case 2:
//            return 300
//        default:
//            return 400
//        }
        
        return 120
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        cell.name.text = MyHomeList5Data[indexPath.row].name
        cell.name.font = UIFont(name: "Roboto-Regular", size: 14)
        // cell.name.font = .systemFont(ofSize: 14)
        cell.name.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
        
        cell.location.text = MyHomeList5Data[indexPath.row].location
        cell.location.font = UIFont(name: "Roboto-Regular", size: 14)
//        cell.location.font = .systemFont(ofSize: 14)
        cell.location.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
        
        cell.time.text = MyHomeList5Data[indexPath.row].time
        cell.time.font = UIFont(name: "Roboto-Regular", size: 14)
//        cell.time.font = .systemFont(ofSize: 14)
        cell.time.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)

        cell.content.text = MyHomeList5Data[indexPath.row].content
        cell.content.font = UIFont(name: "Roboto-Regular", size: 14)
//        cell.content.font = .systemFont(ofSize: 14)
        cell.content.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
        
        cell.img.image = MyHomeList5Data[indexPath.row].profileImage
        
        cell.label1.text = "|"
        cell.label1.font = UIFont(name: "Roboto-Regular", size: 14)
        cell.label1.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
        
        cell.label2.text = "|"
        cell.label2.font = UIFont(name: "Roboto-Regular", size: 14)
        cell.label2.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
        return cell
    }

}

struct MyHomeList5DataModel {
    let profileImage: UIImage?
    let name: String
    let location: String
    let time: String
    let content: String
}

let MyHomeList5Data: [MyHomeList5DataModel] = [
    MyHomeList5DataModel(
            profileImage: UIImage(named: "characterExample4"),
            name: "차라나",
            location: "경기도 성남시",
            time: "10분전",
            content: "제가 3시쯤에 수업이 끝날거 같은데 ..."
        ),
    MyHomeList5DataModel(
            profileImage: UIImage(named: "characterExample4"),
            name: "카리나",
            location: "경기도 성남시",
            time: "10분전",
            content: "제가 5시쯤에 수업이 끝날거 같은데 ..."
        )
]

