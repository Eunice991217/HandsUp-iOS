//
//  ChatListViewController.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/01/16.
//

import UIKit

class ChatListViewController: UIViewController {


    @IBOutlet weak var chatAlarmTableView_CLVC: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatAlarmTableView_CLVC.delegate = self
        chatAlarmTableView_CLVC.dataSource = self
        chatAlarmTableView_CLVC.rowHeight = 84
        
        chatAlarmTableView_CLVC.clipsToBounds = false
        chatAlarmTableView_CLVC.layer.masksToBounds = false
        
        chatAlarmTableView_CLVC.backgroundColor = UIColor(named: "HandsUpBackGround")
        // Do any additional setup after loading the view.
    }


}

extension ChatListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return MyChatData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatAlarmTableViewCell", for: indexPath) as! ChatAlarmTableViewCell
        
        cell.characterView_CATVC.setUserCharacter()

        cell.timeLb_CATVC.text = MyChatData[indexPath.row].time
        cell.idLb_CATVC.text = MyChatData[indexPath.row].name
        cell.contentLb_CATVC.text = MyChatData[indexPath.row].content
        
        cell.countLb_CATVX.text = String(MyChatData[indexPath.row].newMsgCount)
        if(MyChatData[indexPath.row].newMsgCount == 0 ){
            cell.countLb_CATVX.isHidden = true
        }
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController else { return  }
        
        nextVC.chatPersonName = MyChatData[indexPath.row].name
        nextVC.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        
    
        present(nextVC, animated: false, completion: nil)
        
    }
    
}

struct MyChatDataModel {
    let profileImage: UIImage?
    let name: String
    let time: String
    let content: String
    let newMsgCount: Int
}

let MyChatData: [MyChatDataModel] = [
    MyChatDataModel(
            profileImage: UIImage(named: "characterExample2"),
            name: "차라나",
            time: "1:17PM",
            content: "제가 3시쯤에 수업이 끝날거 같은데 3시 30에 학교근처..",
            newMsgCount: 0
        ),
    MyChatDataModel(
            profileImage: UIImage(named: "characterExample3"),
            name: "천애플",
            time: "12:17PM",
            content: "제가 3시쯤에 수업이 끝날거 같은데 3시 30에 학교근처..",
            newMsgCount: 3
        )
]
