//
//  ViewController.swift
//  Test
//
//  Created by 김민경 on 2023/01/17.
//

import UIKit
import CoreLocation

class ListSecondTabVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Properties
    let myTableView: UITableView = UITableView()
    
    var HomeList : [boardsShowList_rp_getBoardList] = [] // boardsShowList_rp_getBoardList
    
    var boardsCharacterListTalk: [Int] = []
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
        // print("Home Talk Page 서버통신 성공 및 원소 개수 ==  \(HomeList.count)")
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard? = UIStoryboard(name: "Main", bundle: Bundle.main)
                       
        // 스토리보드에서 지정해준 ViewController의 ID
        guard let myProfile = storyboard?.instantiateViewController(identifier: "MyProfile") as? MyProfile else { return }
        myProfile.modalPresentationStyle = .overFullScreen
        
        let filteredList = HomeList.filter { $0.tag == "Talk" }
        
        myProfile.HomeList = filteredList
        myProfile.startPage = indexPath.row
        
        self.present(myProfile, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let filteredList = HomeList.filter { $0.tag == "Talk" } // 태그에 맞는 요소만 필터링하여 새로운 배열 생성
            return filteredList.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filteredList = HomeList.filter { $0.tag == "Talk" } // 태그에 맞는 요소만 필터링하여 새로운 배열 생성
        print("table View filteredList Talk 성공 및 원소 개수 == \(filteredList.count)")
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    var findLocation:CLLocation!
    let geocoder = CLGeocoder()
    var longitude_HVC = 0.0
    var latitude_HVC = 0.0
    var finalAddress = ""
    
    func getAddressByLocation(latitude: Double, longitude: Double, completion: @escaping (String?) -> Void) {
        print("위도, 경도 변환 함수 호출 테스트")
        findLocation = CLLocation(latitude: latitude, longitude: longitude)
        print("latitude: \(latitude), longitude: \(longitude)")
        if findLocation != nil {
            geocoder.reverseGeocodeLocation(findLocation!) { [self] (placemarks, error) in
                if error != nil {
                    completion(nil)
                    return
                }
                if let placemark = placemarks?.first {
                    var address = ""
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
                    completion(address)
                } else {
                    completion(nil)
                }
            }
        } else {
            completion(nil)
        }
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id, for: indexPath) as? ListTableViewCell else {
                return UITableViewCell()
            }

        let filteredList = HomeList.filter { $0.tag == "Talk" } // 태그에 맞는 요소만 필터링하여 새로운 배열 생성
        let item = filteredList[indexPath.row]

        cell.name.text = item.nickname
        cell.name.font = UIFont(name: "Roboto-Regular", size: 14)
        cell.name.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)

        let latitude = item.board.latitude
        let longitude = item.board.longitude

        getAddressByLocation(latitude: latitude, longitude: longitude) { [weak self] address in
            DispatchQueue.main.async {
                if item.board.indicateLocation == "true" {
                    cell.location.text = address
                } else {
                    cell.location.text = "위치 비밀"
                }
            }
        }

        print("Talk cell 위치값 확인 : \(String(describing: cell.location.text))")
        cell.location.font = UIFont(name: "Roboto-Regular", size: 14)
        cell.location.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)

        let createDate = item.board.createdAt.toDate()
        cell.time.text = createDate.getTimeDifference()
        cell.time.font = UIFont(name: "Roboto-Regular", size: 14)
        cell.time.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)

        cell.content.text = item.board.content
        cell.content.font = UIFont(name: "Roboto-Regular", size: 14)
        cell.content.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)

        cell.label1.text = "|"
        cell.label1.font = UIFont(name: "Roboto-Regular", size: 14)
        cell.label1.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)

        cell.label2.text = "|"
        cell.label2.font = UIFont(name: "Roboto-Regular", size: 14)
        cell.label2.textColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)

        boardsCharacterListTalk = [] // 빈 배열

        let characterBoards = item.character

        background = (Int(characterBoards.backGroundColor) ?? 1) - 1
        hair = (Int(characterBoards.hair) ?? 1) - 1
        eyebrow = (Int(characterBoards.eyeBrow) ?? 1) - 1
        mouth = (Int(characterBoards.mouth) ?? 1) - 1
        nose = (Int(characterBoards.nose) ?? 1) - 1
        eyes = (Int(characterBoards.eye) ?? 1) - 1
        glasses = Int(characterBoards.glasses) ?? 0

        boardsCharacterListTalk.append(background)
        boardsCharacterListTalk.append(hair)
        boardsCharacterListTalk.append(eyebrow)
        boardsCharacterListTalk.append(mouth)
        boardsCharacterListTalk.append(nose)
        boardsCharacterListTalk.append(eyes)
        boardsCharacterListTalk.append(glasses)

        cell.img.setAll(componentArray: boardsCharacterListTalk) // 가져오기
        cell.img.setCharacter_NoShadow() // 그림자 없애기
        cell.img.setCharacter() // 캐릭터 생성

        cell.selectionStyle = .none

        return cell
    }

}
