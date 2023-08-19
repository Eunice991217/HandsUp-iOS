import UIKit
import SwiftUI

class MyProfileView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var MyProfileCollectionView: UICollectionView!
    
    var HomeCardList : [boardsShowList_rp_getBoardList] = []
    var boardsCharacterList: [Int] = []
    var background = 0, hair = 0, eyebrow = 0, mouth = 0, nose = 0, eyes = 0, glasses = 0
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("viewDidAppear Collection View 성공 및 원소 개수 == \(HomeCardList.count)")
        return HomeCardList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProfileCollectionViewCell", for: indexPath) as! MyProfileCollectionViewCell
        
        boardsCharacterList = [] // 빈 배열

        let characterBoards = HomeCardList[indexPath.row].character

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

        cell.profileImage.setAll(componentArray: boardsCharacterList) // 가져오기
        cell.profileImage.setCharacter_NoShadow() // 그림자 없애기
        cell.profileImage.setCharacter() // 캐릭터 생성

        cell.smallName.text=HomeCardList[indexPath.row].nickname
        cell.largeName.text=HomeCardList[indexPath.row].nickname


        let createDate = HomeCardList[indexPath.row].board.createdAt.toDate()
        cell.time.text=createDate.getTimeDifference()

        cell.content.text=HomeCardList[indexPath.row].board.content
        cell.content.sizeToFit()
        
        cell.tagType.text = "#" + HomeCardList[indexPath.row].tag
        cell.tagType.font = UIFont(name: "Roboto-Bold", size: 14)


        let schoolName = HomeCardList[indexPath.row].schoolName
        var cutSchoolName: String = ""

        if(schoolName.count == 6) {
            _ = schoolName.index(schoolName.startIndex, offsetBy: 0)
            let endIndex = schoolName.index(schoolName.startIndex, offsetBy: 3)
            let range = ...endIndex

            cutSchoolName = String(schoolName[range])
        }
        else if(schoolName.count == 5) {
            _ = schoolName.index(schoolName.startIndex, offsetBy: 0)
            let endIndex = schoolName.index(schoolName.startIndex, offsetBy: 2)
            let range = ...endIndex

            cutSchoolName = String(schoolName[range])
        }

        cell.school.text = cutSchoolName
        cell.school.font = UIFont(name: "Roboto-Bold", size: 14)


        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0 // cell사이의 간격 설정
        
        MyProfileCollectionView.backgroundColor = .none
        MyProfileCollectionView.collectionViewLayout = flowLayout
        
        MyProfileCollectionView.delegate = self
        MyProfileCollectionView.dataSource = self
        
        HomeCardList = HomeServerAPI.boardsShowList() ?? []
        print("MyProfile 서버통신 성공 및 원소 개수 ==  \(HomeCardList.count)")
        
        setupView()
        
        //        let postCollectionViewCell = UIHostingController(rootView: PostCollectionviewCell())
        //        addChild(postCollectionViewCell)
        //        postCollectionViewCell.view.frame = view.bounds
        //        view.addSubview(postCollectionViewCell.view)
        //        postCollectionViewCell.didMove(toParent: self)
    }
    
    func setupView() {
        // 6. add blur view and send it to back
        view.addSubview(blurredView)
        view.sendSubviewToBack(blurredView)
    }
    
    lazy var blurredView: UIView = {
        // 1. create container view
        let containerView = UIView()
        // 2. create custom blur view
        let blurEffect = UIBlurEffect(style: .light)
        let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.4)
        customBlurEffectView.frame = self.view.bounds
        // 3. create semi-transparent black view
        let dimmedView = UIView()
        dimmedView.backgroundColor = .black.withAlphaComponent(0.3)
        dimmedView.frame = self.view.bounds
        
        // 4. add both as subviews
        containerView.addSubview(customBlurEffectView)
        containerView.addSubview(dimmedView)
        return containerView
    }()
}

extension MyProfileView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
