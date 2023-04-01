//
//  ViewController.swift
//  Test
//
//  Created by 김민경 on 2023/01/17.
//

import UIKit

class ListSecondTabVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//class ListSecondTabVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    // MARK: Properties
//    let myTableView: UITableView = UITableView()
//
//    var HomeList : [boardsShowList_rp_getBoardList] = [] // boardsShowList_rp_getBoardList
//
//    var boardsCharacterList: [Int] = []
//    var background = 0, hair = 0, eyebrow = 0, mouth = 0, nose = 0, eyes = 0, glasses = 0
//
//    // MARK: ViewController override method
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        self.myTableView.dataSource = self
//        self.myTableView.delegate = self
//
//        self.myTableView.register(ListTableViewCell.self,
//                              forCellReuseIdentifier: "ListTableViewCell")
//
//        self.view.addSubview(self.myTableView)
//
//        myTableView.separatorStyle = .none
//
//        myTableView.backgroundColor = UIColor(red: 0.975, green: 0.975, blue: 0.975, alpha: 1)
//
//        self.myTableView.translatesAutoresizingMaskIntoConstraints = false
//
//        self.view.addConstraint(NSLayoutConstraint(item: self.myTableView,
//        attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top,
//        multiplier: 1.0, constant: 0))
//        self.view.addConstraint(NSLayoutConstraint(item: self.myTableView,
//        attribute: .bottom, relatedBy: .equal, toItem: self.view,
//        attribute: .bottom, multiplier: 1.0, constant: 0))
//        self.view.addConstraint(NSLayoutConstraint(item: self.myTableView,
//        attribute: .leading, relatedBy: .equal, toItem: self.view,
//        attribute: .leading, multiplier: 1.0, constant: 0))
//        self.view.addConstraint(NSLayoutConstraint(item: self.myTableView,
//        attribute: .trailing, relatedBy: .equal, toItem: self.view,
//        attribute: .trailing, multiplier: 1.0, constant: 0))
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard: UIStoryboard? = UIStoryboard(name: "Main", bundle: Bundle.main)
//
//        // 스토리보드에서 지정해준 ViewController의 ID
//        guard let myProfile = storyboard?.instantiateViewController(identifier: "MyProfile") else {return}
//        myProfile.modalPresentationStyle = .overFullScreen
//        self.present(myProfile, animated: true)
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return MyHomeList2Data.count
////        return HomeList.count
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
////        switch indexPath.row {
////        case 0:
////            return 100
////        case 1:
////            return 200
////        case 2:
////            return 300
////        default:
////            return 400
////        }
//
//        return 120
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
//
//        cell.name.text = MyHomeList2Data[indexPath.row].name
//        cell.name.font = UIFont(name: "Roboto-Regular", size: 14)
//        // cell.name.font = .systemFont(ofSize: 14)
//        cell.name.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
//
//        cell.location.text = MyHomeList2Data[indexPath.row].location
//        cell.location.font = UIFont(name: "Roboto-Regular", size: 14)
////        cell.location.font = .systemFont(ofSize: 14)
//        cell.location.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
//
//        cell.time.text = MyHomeList2Data[indexPath.row].time
//        cell.time.font = UIFont(name: "Roboto-Regular", size: 14)
////        cell.time.font = .systemFont(ofSize: 14)
//        cell.time.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
//
//        cell.content.text = MyHomeList2Data[indexPath.row].content
//        cell.content.font = UIFont(name: "Roboto-Regular", size: 14)
////        cell.content.font = .systemFont(ofSize: 14)
//        cell.content.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
//
//        cell.img.image = MyHomeList2Data[indexPath.row].profileImage
//
//        cell.label1.text = "|"
//        cell.label1.font = UIFont(name: "Roboto-Regular", size: 14)
//        cell.label1.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
//
//        cell.label2.text = "|"
//        cell.label2.font = UIFont(name: "Roboto-Regular", size: 14)
//        cell.label2.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
//
////        cell.name.text = HomeList[indexPath.row].nickname
////        cell.name.font = UIFont(name: "Roboto-Regular", size: 14)
////        cell.name.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
////
////        cell.location.text = String(HomeList[indexPath.row].board.latitude) // 위도, 경도 ~도, ~시 string으로 받기
////        cell.location.font = UIFont(name: "Roboto-Regular", size: 14)
////        cell.location.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
////
////        cell.time.text = HomeList[indexPath.row].board.createdAt
////        cell.time.font = UIFont(name: "Roboto-Regular", size: 14)
////        cell.time.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
////
////        cell.content.text = HomeList[indexPath.row].board.content
////        cell.content.font = UIFont(name: "Roboto-Regular", size: 14)
////        cell.content.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
////
////        cell.label1.text = "|"
////        cell.label1.font = UIFont(name: "Roboto-Regular", size: 14)
////        cell.label1.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
////
////        cell.label2.text = "|"
////        cell.label2.font = UIFont(name: "Roboto-Regular", size: 14)
////        cell.label2.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
////
////        boardsCharacterList = [] // 빈 배열
////        let boardsCharacter = HomeList[indexPath.row].character // 서버에서 캐릭터값 받아오기
////
////        background = (Int(boardsCharacter.backGroundColor) ?? 1) - 1
////        hair = (Int(boardsCharacter.hair) ?? 1) - 1
////        eyebrow = (Int(boardsCharacter.eyeBrow) ?? 1) - 1
////        mouth = (Int(boardsCharacter.mouth) ?? 1) - 1
////        nose = (Int(boardsCharacter.nose) ?? 1) - 1
////        eyes = (Int(boardsCharacter.eye) ?? 1) - 1
////        glasses = Int(boardsCharacter.glasses) ?? 0
////
////        boardsCharacterList.append(background)
////        boardsCharacterList.append(hair)
////        boardsCharacterList.append(eyebrow)
////        boardsCharacterList.append(mouth)
////        boardsCharacterList.append(nose)
////        boardsCharacterList.append(eyes)
////        boardsCharacterList.append(glasses)
////
////        cell.img.setAll(componentArray: boardsCharacterList) // 가져오기
////        cell.img.setCharacter_NoShadow() // 그림자 없애기
////        cell.img.setCharacter() // 캐릭터 생성
//
//        cell.selectionStyle = .none
//
//        return cell
//    }
//
//}
//
//struct MyHomeList2DataModel {
//    let profileImage: UIImage?
//    let name: String
//    let location: String
//    let time: String
//    let content: String
//}
//
//let MyHomeList2Data: [MyHomeList2DataModel] = [
//    MyHomeList2DataModel(
//            profileImage: UIImage(named: "characterExample4"),
//            name: "차라나",
//            location: "경기도 성남시",
//            time: "10분전",
//            content: "제가 3시쯤에 수업이 끝날거 같은데 ..."
//        ),
//    MyHomeList2DataModel(
//            profileImage: UIImage(named: "characterExample4"),
//            name: "카리나",
//            location: "경기도 성남시",
//            time: "10분전",
//            content: "제가 5시쯤에 수업이 끝날거 같은데 ..."
//        )
//]

