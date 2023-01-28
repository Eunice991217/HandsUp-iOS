//
//  ChatListViewController.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/01/16.
//

import UIKit

class ChatListViewController: UIViewController {


    @IBOutlet weak var chatAlarmTableView_CLVC: UITableView!
    
    let imgArr_CLVC = ["characterExample3", "characterExample2", "characterExample3", "characterExample3", "characterExample2", "characterExample3","characterExample3", "characterExample2", "characterExample3"]
    
    let idLbArr_CLVC = ["차라나", "김라나", "천라나", "차애플", "김애플", "천애플","차안드", "김안드", "천안드"]
    
    let timeLbArr_CLVC = ["12:11AM", "12:13AM", "12:17AM", "12:21AM", "12:31AM", "12:33AM","12:44AM", "12:49AM", "12:59AM"]
    
    let contentArr_CLVC = ["안녕하세요 글보고 연락드려요 수업끝나1111111", "안녕하세요 글보고 연락드려요 수업끝나222222", "안녕하세요 글보고 연락드려요 수업끝나3333333", "안녕하세요 글보고 연락드려요 수업끝나4444444", "안녕하세요 글보고 연락드려요 수업끝나5555555","안녕하세요 글보고 연락드려요 수업끝나666666", "안녕하세요 글보고 연락드려요 수업끝나777777", "안녕하세요 글보고 연락드려요 수업끝나88888", "안녕하세요 글보고 연락드려요 수업끝나99999"]
    
    let msgCountArr_CLVC = [1, 3, 5, 2, 3, 6, 7, 4, 2]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatAlarmTableView_CLVC.delegate = self
        chatAlarmTableView_CLVC.dataSource = self
        chatAlarmTableView_CLVC.rowHeight = 84
        
        chatAlarmTableView_CLVC.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }


}
extension ChatListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatAlarmTableViewCell", for: indexPath) as! ChatAlarmTableViewCell
        
        cell.characterImgView_CATVC.image = UIImage(named: imgArr_CLVC[indexPath.row])
        cell.timeLb_CATVC.text = timeLbArr_CLVC[indexPath.row]
        cell.idLb_CATVC.text = idLbArr_CLVC[indexPath.row]
        cell.contentLb_CATVC.text = contentArr_CLVC[indexPath.row]
        
        cell.countLb_CATVX.text = String(msgCountArr_CLVC[indexPath.row])
        
        cell.selectionStyle = .none
        return cell
    }
  //  private func tableView(tableView: UITableView, didSelectRowAtIndexPath /indexPath: NSIndexPath) {
    //    let storyboard = UIStoryboard(name: "HandsUp", bundle: nil)
   //     let viewController = /storyboard.instantiateViewController(withIdentifier: "ChatViewController")
    //    self.navigationController?.pushViewController(viewController, animated: true)
   // }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") else { return  }
        
        destinationVC.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        present(destinationVC, animated: false, completion: nil)
        
    }
    
}
