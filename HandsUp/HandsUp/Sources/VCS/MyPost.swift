//
//  MyPost.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/14.
//

import UIKit
import CoreLocation

class MyPost: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var myPostArr: [myBoards_rp_myBoardList] = []
    var findLocation:CLLocation!
    let geocoder = CLGeocoder()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("myPostArr.count : \(myPostArr.count)")
        return myPostArr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard? = UIStoryboard(name: "HandsUp", bundle: Bundle.main)
                
        // 스토리보드에서 지정해준 ViewController의 ID
        guard let registerPostVC = storyboard?.instantiateViewController(identifier: "RegisterPostViewController") else {return}
        
        // 화면 전환!
        self.present(registerPostVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 테이블뷰에 넣을 셀
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPostTableViewCell", for: indexPath) as? MyPostTableViewCell else {return UITableViewCell() }
               
        // 몇번째 셀에 어떤것이 들어가는지 모르기때문에 indexPath활용
        cell.MyPostTableViewCellImage.setUserCharacter()
        
        cell.MyPostTableViewCellName.text = UserDefaults.standard.string(forKey: "nickname")!
//        cell.MyPostTableViewCellLoaction.text = getAddressByLocation(latitiude: myPostArr[indexPath.row].latitude, longitude: myPostArr[indexPath.row].longitude)
        cell.MyPostTableViewCellLoaction.text = myPostArr[indexPath.row].location
        cell.MyPostTableViewCellTime.text =  myPostArr[indexPath.row].createdAt.toDate().getTimeDifference()
        cell.MyPostTableViewCellContent.text = myPostArr[indexPath.row].content
        
        cell.selectionStyle = .none
       
        return cell // 테이블뷰에 넣을 셀
    }
    
    @IBOutlet weak var HomeMyPostTableView: UITableView!
    
    
    @IBAction func MyPostBackBtnDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HomeMyPostTableView.delegate = self
        HomeMyPostTableView.dataSource = self
        
        HomeMyPostTableView.clipsToBounds = false
        HomeMyPostTableView.backgroundColor = UIColor(named: "HandsUpBackGround")
        
        HomeMyPostTableView.separatorStyle = .none

        self.navigationController?.navigationBar.isHidden = true;
        
        myPostArr = ServerAPI.myBoards() ?? []
//        self.navigationController?.navigationBar.tintColor = .black
//        self.navigationController?.navigationBar.topItem?.title = ""
        // Do any additional setup after loading the view.
    }
    
    private func getAddressByLocation(latitiude: Double, longitude: Double) -> String {
        findLocation = CLLocation(latitude: latitiude, longitude: longitude)
        var address = ""
        if findLocation != nil {
           
            geocoder.reverseGeocodeLocation(findLocation!) { (placemarks, error) in
                if error != nil {
                    return
                }
                if let placemark = placemarks?.first {
                    
                    if let administrativeArea = placemark.administrativeArea {
                        //address = "\(address) \(administrativeArea) "
                    }
                    
                    if let locality = placemark.locality {
                        address = "\(address) \(locality) "
                    }
                    
                    if let thoroughfare = placemark.thoroughfare {
                        address = "\(address) \(thoroughfare) "
                    }
                    
                    if let subThoroughfare = placemark.subThoroughfare {
                        // address = "\(address) \(subThoroughfare)"

                    }
                }
               
            }
        }
        return address
    }

}
