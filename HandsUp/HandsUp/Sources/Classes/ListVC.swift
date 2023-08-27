//
//  ListVC.swift
//  HandsUp
//
//  Created by 황재상 on 8/27/23.
//

import Foundation
import UIKit

class ListVC: UIViewController {
    let myTableView: UITableView = UITableView()
    var HomeList : [boardsShowList_rp_getBoardList] = [] // boardsShowList_rp_getBoardList
    
    func refresh(){
        HomeList = HomeServerAPI.boardsShowList() ?? []
        myTableView.reloadData()
        print("refresh")
    }
}
