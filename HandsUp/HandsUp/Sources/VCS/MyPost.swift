//
//  MyPost.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/14.
//

import UIKit

class MyPost: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyPostData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 테이블뷰에 넣을 셀
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPostTableViewCell", for: indexPath) as? MyPostTableViewCell else {return UITableViewCell() }
               
               // 몇번째 셀에 어떤것이 들어가는지 모르기때문에 indexPath활용
               cell.MyPostTableViewCellImage.image = MyPostData[indexPath.row].profileImage
               cell.MyPostTableViewCellName.text=MyPostData[indexPath.row].name
               cell.MyPostTableViewCellLoaction.text=MyPostData[indexPath.row].location
               cell.MyPostTableViewCellTime.text=MyPostData[indexPath.row].time
               cell.MyPostTableViewCellContent.text=MyPostData[indexPath.row].content
               
               return cell // 테이블뷰에 넣을 셀
    }
    
    @IBOutlet weak var HomeMyPostTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HomeMyPostTableView.delegate = self
        HomeMyPostTableView.dataSource = self

        // Do any additional setup after loading the view.
    }

}

struct MyPostDataModel {
    let profileImage: UIImage?
    let name: String
    let location: String
    let time: String
    let content: String
}

let MyPostData: [MyPostDataModel] = [
    MyPostDataModel(
            profileImage: UIImage(named: "characterExample2"),
            name: "차라나",
            location: "경기도 성남시",
            time: "10분전",
            content: "제가 3시쯤에 수업이 끝날거 같은데 3시 30에 학교근처.."
        ),
    MyPostDataModel(
            profileImage: UIImage(named: "characterExample3"),
            name: "차라나",
            location: "경기도 성남시",
            time: "10분전",
            content: "제가 3시쯤에 수업이 끝날거 같은데 3시 30에 학교근처.."
        )
]
