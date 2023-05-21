//
//  ListFirstTabVC.swift
//  Test
//
//  Created by 김민경 on 2023/01/17.
//

import UIKit
import CoreLocation

class ListFirstTabVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Properties
    let myTableView: UITableView = UITableView()
    
    var HomeList : [boardsShowList_rp_getBoardList] = [] // boardsShowList_rp_getBoardList
    
    var boardsCharacterList: [Int] = []
    var background = 0, hair = 0, eyebrow = 0, mouth = 0, nose = 0, eyes = 0, glasses = 0
    

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
        
        HomeList = HomeServerAPI.boardsShowList() ?? []
        print("Home 서버통신 성공 및 원소 개수 ==  \(HomeList.count)")
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//             print("viewDidAppear table View 성공 및 원소 개수 == \(HomeList.count)")
//             return HomeList.count
//        }
//    }
    
        override func viewWillDisappear(_ animated: Bool) {
    
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                 print("viewWillDisappear table View 성공 및 원소 개수 == \(HomeList.count)")
                 return HomeList.count
            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard? = UIStoryboard(name: "Main", bundle: Bundle.main)
                       
        // 스토리보드에서 지정해준 ViewController의 ID
        guard let myProfile = storyboard?.instantiateViewController(identifier: "MyProfile") as? MyProfile else {return}
        myProfile.modalPresentationStyle = .overFullScreen
        
        myProfile.startPage = indexPath.row
        self.present(myProfile, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         //return MyHomeList1Data.count
         print("HomeList 서버통신 개수 tableView == \(HomeList.count)")
         return HomeList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    var findLocation:CLLocation!
    let geocoder = CLGeocoder()
    var longitude_HVC = 0.0
    var latitude_HVC = 0.0
    var finalAddress = ""
    
    func getAddressByLocation(latitude: Double, longitude: Double) -> String {
        print("위도, 경도 변환 함수 호출 테스트")
        findLocation = CLLocation(latitude: latitude, longitude: longitude)
        print("latitude: \(latitude), longitude: \(longitude)")
        if findLocation != nil {
            var address = ""
            geocoder.reverseGeocodeLocation(findLocation!) { [self] (placemarks, error) in
                if error != nil {
                    return
                }
                if let placemark = placemarks?.first {
                    if placemark.administrativeArea != nil {
                         // address = "\(address) \(administrativeArea) "
                    }
                    if let locality = placemark.locality {
                         address = "\(address)\(locality) "
                    }
                    if let thoroughfare = placemark.thoroughfare {
                         address = "\(address)\(thoroughfare)"
                    }
                    if placemark.subThoroughfare != nil {
                         // address = "\(address) \(subThoroughfare)"
                    }
                    finalAddress = address.copy() as! String
                }
            }
        }
        return self.finalAddress
    }

    var tagCnt = 0

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        boardsCharacterList = [] // 빈 배열
        
        let characterBoards = HomeList[indexPath.row].character
        
        background = (Int(characterBoards.backGroundColor) ?? 1) - 1
        hair = (Int(characterBoards.hair) ?? 1) - 1
        eyebrow = (Int(characterBoards.eyeBrow) ?? 1) - 1
        mouth = (Int(characterBoards.mouth) ?? 1) - 1
        nose = (Int(characterBoards.nose) ?? 1) - 1
        eyes = (Int(characterBoards.eye) ?? 1) - 1
        glasses = Int(characterBoards.glasses) ?? 0
        
        boardsCharacterList.append(background)
        boardsCharacterList.append(hair)
        boardsCharacterList.append(eyebrow)
        boardsCharacterList.append(mouth)
        boardsCharacterList.append(nose)
        boardsCharacterList.append(eyes)
        boardsCharacterList.append(glasses)
        
        cell.img.setAll(componentArray: boardsCharacterList) // 가져오기
        cell.img.setCharacter_NoShadow() // 그림자 없애기
        cell.img.setCharacter() // 캐릭터 생성
        
        cell.name.text = HomeList[indexPath.row].nickname
        cell.name.font = UIFont(name: "Roboto-Regular", size: 14)
        cell.name.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
        
//        cell.location.text = getAddressByLocation (latitude: HomeList[indexPath.row].board.latitude, longitude: HomeList[indexPath.row].board.longitude)
        
        
        let locationText = getAddressByLocation(latitude: HomeList[indexPath.row].board.latitude, longitude: HomeList[indexPath.row].board.longitude)
        if locationText == nil {
            cell.location.text = "위치 비밀"
        } else {
            cell.location.text = locationText
        }
        
        print("cell 위치값 확인 : \(String(describing: cell.location.text))")
        cell.location.font = UIFont(name: "Roboto-Regular", size: 14)
        cell.location.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
        
        let createDate = HomeList[indexPath.row].board.createdAt.toDate()
        cell.time.text = createDate.getTimeDifference()
        cell.time.font = UIFont(name: "Roboto-Regular", size: 14)
        cell.time.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
        
        cell.content.text = HomeList[indexPath.row].board.content
        cell.content.font = UIFont(name: "Roboto-Regular", size: 14)
        cell.content.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
        
        cell.label1.text = "|"
        cell.label1.font = UIFont(name: "Roboto-Regular", size: 14)
        cell.label1.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
        
        cell.label2.text = "|"
        cell.label2.font = UIFont(name: "Roboto-Regular", size: 14)
        cell.label2.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
        
        
        
        cell.selectionStyle = .none
        
        return cell
    }

}


