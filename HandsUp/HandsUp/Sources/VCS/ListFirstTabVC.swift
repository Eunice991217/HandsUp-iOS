//
//  ViewController.swift
//  Test
//
//  Created by 김민경 on 2023/01/17.
//

import UIKit

class ListFirstTabVC: UIViewController {

    // MARK: Properties
    let myTableView: UITableView = UITableView()
    let items: [String] = ["magi82", "swift", "ios"]

    // MARK: ViewController override method
    override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
      self.myTableView.dataSource = self
      self.myTableView.delegate = self
        
      self.myTableView.register(TableViewCell.self,
                              forCellReuseIdentifier: "TableViewCell")
        
      self.view.addSubview(self.myTableView)

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

}

// MARK: UITableViewDelegate
extension ListFirstTabVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(items[indexPath.row])
      tableView.cellForRow(at: indexPath)?.contentView.backgroundColor = .blue
  }
}

// MARK: UITableViewDataSource
extension ListFirstTabVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 100
        case 1:
            return 200
        case 2:
            return 300
        default:
            return 400
        }
        
        //return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        
        cell.title.text = items[indexPath.row]
        cell.title.textColor = .black
        print("아아아아아아아아악")
        return cell
    }
}

