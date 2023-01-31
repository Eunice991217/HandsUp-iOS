//
//  MyProfile.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/31.
//

import UIKit

class MyProfile: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var MyProfileCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return MyProfileData.count
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProfileCollectionViewCell", for: indexPath) as! MyProfileCollectionViewCell
        
        cell.MyProfileCellImage.image = MyProfileData[indexPath.row].profileImage
        cell.MyProfileSmallName.text=MyProfileData[indexPath.row].name
        cell.MyProfileCellLargeName.text=MyProfileData[indexPath.row].name
        cell.MyProfileCellLocation.text=MyProfileData[indexPath.row].location
        cell.MyProfileCellTime.text=MyProfileData[indexPath.row].time
        cell.MyProfileCellContent.text=MyProfileData[indexPath.row].content
        cell.MyProfileCellContent.sizeToFit()
        cell.MyProfileCellTag.text=MyProfileData[indexPath.row].tag
        cell.MyProfileCellTag.font = UIFont(name: "Roboto-Bold", size: 14)
        cell.MyProfileTag.cornerRadius = 12

        return cell
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout = UICollectionViewFlowLayout()
               flowLayout.scrollDirection = .horizontal
               flowLayout.minimumLineSpacing = 0 // cell사이의 간격 설정
       
               MyProfileCollectionView.collectionViewLayout = flowLayout
        
        MyProfileCollectionView.delegate = self
        MyProfileCollectionView.dataSource = self
        
    }


}

extension MyProfile: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

struct MyProfileDataModel {
    let profileImage: UIImage?
    let name: String
    let location: String
    let time: String
    let content: String
    let tag: String
}

let MyProfileData: [MyProfileDataModel] = [
    MyProfileDataModel(
            profileImage: UIImage(named: "characterExample4"),
            name: "차라나",
            location: "경기도 성남시",
            time: "10분전",
            content: "제가 3시쯤에 수업이 끝날거 같은데 3시 30에 학교근처..",
            tag: "#스터디"
        ),
    MyProfileDataModel(
            profileImage: UIImage(named: "characterExample3"),
            name: "카리나",
            location: "경기도 성남시",
            time: "40분전",
            content: "제가 6시쯤에 수업이 끝날거 같은데 7시 30에 학교근처..",
            tag: "#취미"
        ),
    MyProfileDataModel(
            profileImage: UIImage(named: "characterExample2"),
            name: "오나라",
            location: "경기도 성남시",
            time: "15분전",
            content: "제가 4시쯤에 수업이 끝날거 같은데 5시 30에 학교근처..",
            tag: "#밥"
        )
]
