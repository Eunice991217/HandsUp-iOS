//
//  MyProfile.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/31.
//

import UIKit
import CoreLocation

class MyProfile: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var MyProfileCollectionView: UICollectionView!
    
    var HomeList : [boardsShowList_rp_getBoardList] = []
    
    var boardsCharacterList: [Int] = []
    var background = 0, hair = 0, eyebrow = 0, mouth = 0, nose = 0, eyes = 0, glasses = 0
    
    @IBOutlet var MyProfileHeartBtn: UIButton!
    
    var bRec:Bool = true
    
    var startPage: Int = 0
    
    var selectedIndexPath: IndexPath?
    
    var boardIndex: Int64?
    
    @IBAction func HeartBtnDidTap(_ sender: Any) {
        bRec = !bRec
        
        if bRec { // 비어진 하트
            MyProfileHeartBtn.setImage(UIImage(named: "HeartSmall"), for: .normal)
            print("하트 버튼을 취소했습니다.")
        } else { // 버튼 눌렀을때 채워진 하트
            MyProfileHeartBtn.setImage(UIImage(named: "HeartDidTap"), for: .normal)
            if let boardIndex = boardIndex {
                let stat = HomeServerAPI.boardsHeart(boardIdx: boardIndex) // 클릭한 id값 전달해야함
                print("하트 버튼을 클릭했습니다. \(boardIndex)")
            }
        }
    }
    
    @IBAction func MyProfilemoreDidTap(_ sender: Any) {
        let currentUserNickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
        
        guard let selectedIndexPath = selectedIndexPath else {
            return
        }
        
        let postAuthorNickname = HomeList[selectedIndexPath.row].nickname
        let isMyPost = currentUserNickname == postAuthorNickname
        
        self.showAlertController(style: .actionSheet, isMyPost: isMyPost)
    }
    
    func showAlertController(style: UIAlertController.Style, isMyPost: Bool) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "닫기", style: .cancel) { (action) in }
        alert.addAction(cancel)
        
        let Report = self.storyboard?.instantiateViewController(withIdentifier: "Report")
        
        if isMyPost {
            let delete = UIAlertAction(title: "삭제하기", style: .destructive) { (action) in
                // 삭제 기능 실행
            }
            alert.addAction(delete)
            
            
            let edit = UIAlertAction(title: "수정하기", style: .default) { (action) in
                // 수정 기능 실행
                
                let myTabVC = UIStoryboard.init(name: "HandsUp", bundle: nil)
                guard let nextVC = myTabVC.instantiateViewController(identifier: "RegisterPostViewController") as? RegisterPostViewController else {
                    return
                }
                nextVC.isEdited = true; nextVC.editedBoard = self.HomeList[self.selectedIndexPath!.row].board; nextVC.selectedTag_HVC = self.HomeList[self.selectedIndexPath!.row].tag
                self.present(nextVC, animated: true, completion: nil)
            }
            alert.addAction(edit)
            
            let titleTextColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cancel.setValue(titleTextColor, forKey: "titleTextColor")
            
            edit.setValue(UIColor(red: 0.31, green: 0.494, blue: 0.753, alpha: 1), forKey: "titleTextColor")
            delete.setValue(titleTextColor, forKey: "titleTextColor")
            
        } else {
            let block = UIAlertAction(title: "이 게시물 그만보기", style: .default) { (action) in
                self.showBlockAlert()
            }
            alert.addAction(block)
            
            let report = UIAlertAction(title: "신고하기", style: .default) { (action) in
                Report?.modalPresentationStyle = .fullScreen
                // 화면 전환!
                
                let transition = CATransition()
                transition.duration = 0.3
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                self.view.window!.layer.add(transition, forKey: kCATransition)
                
                self.present(Report!, animated: false)
            }
            alert.addAction(report)
            
            // 버튼 색상 설정
            let titleTextColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            cancel.setValue(titleTextColor, forKey: "titleTextColor")
            
            report.setValue(UIColor(red: 0.31, green: 0.494, blue: 0.753, alpha: 1), forKey: "titleTextColor")
            block.setValue(titleTextColor, forKey: "titleTextColor")
        }
        
        // 버튼 색상 설정
        let titleTextColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        cancel.setValue(titleTextColor, forKey: "titleTextColor")
        
        
        // 배경색 설정
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
        
        present(alert, animated: true, completion: nil)
    }

    
    func showBlockAlert(){
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "아니요", style: .cancel) { (action) in }; alert.addAction(cancel)
        let confirm = UIAlertAction(title: "네", style: .default) { (action) in }; alert.addAction(confirm)

        confirm.setValue(UIColor(red: 0.563, green: 0.691, blue: 0.883, alpha: 1), forKey: "titleTextColor") //확인버튼 색깔입히기
        cancel.setValue(UIColor(red: 0.663, green: 0.663, blue: 0.663, alpha: 1), forKey: "titleTextColor") //취소버튼 색깔입히기
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        let attributedString = NSAttributedString(string: "해당 게시물을 차단하면 이 게시물은 더이상 볼 수 없습니다.", attributes: [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1)])
        alert.setValue(attributedString, forKey: "attributedTitle") //컨트롤러에 설정한 걸 세팅

        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func MyProfileChatBtnDidTap(_ sender: Any) {
        
        // ChatViewController
        let storyboard: UIStoryboard? = UIStoryboard(name: "HandsUp", bundle: Bundle.main)
        
        guard let nextVC = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController else { return  }
        
        nextVC.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        
    
        present(nextVC, animated: false, completion: nil)
    }
    
    @IBAction func MyProfileDismissBtnDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedIndexPath = indexPath
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("viewDidAppear table View 성공 및 원소 개수 == \(HomeList.count)")
        return HomeList.count
    }
    
    var findLocation:CLLocation!
    let geocoder = CLGeocoder()
    var longitude_HVC = 0.0
    var latitude_HVC = 0.0
    var finalAddress = ""
    
    func getAddressByLocation(latitude: Double, longitude: Double, completion: @escaping (String) -> Void) {
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
        
        completion(finalAddress) // 완료 후 주소를 반환하는 completion 핸들러 호출
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProfileCollectionViewCell", for: indexPath) as! MyProfileCollectionViewCell
        
        boardIndex = Int64(HomeList[indexPath.row].board.boardIdx) // 클릭한 셀의 index 값을 가져옴
        
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
        
        cell.MyProfileCellImage.setAll(componentArray: boardsCharacterList) // 가져오기
        cell.MyProfileCellImage.setCharacter_NoShadow() // 그림자 없애기
        cell.MyProfileCellImage.setCharacter() // 캐릭터 생성
        
        
        cell.MyProfileSmallName.text=HomeList[indexPath.row].nickname
        cell.MyProfileCellLargeName.text=HomeList[indexPath.row].nickname
        
        // getAddressByLocation를 비동기로 호출하고 클로저 내에서 TableView를 업데이트
        getAddressByLocation(latitude: HomeList[indexPath.row].board.latitude, longitude: HomeList[indexPath.row].board.longitude) { address in
            DispatchQueue.main.async {
                cell.MyProfileCellLocation.text = address // 주소를 설정하여 TableView를 업데이트
            }
        }
        
        let createDate = HomeList[indexPath.row].board.createdAt.toDate()
        cell.MyProfileCellTime.text=createDate.getTimeDifference()
        
        cell.MyProfileCellContent.text=HomeList[indexPath.row].board.content
        
        cell.MyProfileCellTag.text = "#" + HomeList[indexPath.row].tag
        cell.MyProfileCellTag.font = UIFont(name: "Roboto-Bold", size: 14)
        
        cell.MyProfileTag.cornerRadius = 12
        
        let schoolName = HomeList[indexPath.row].schoolName
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
    
        cell.MyProfileCellUniv.text = cutSchoolName
        cell.MyProfileCellUniv.font = UIFont(name: "Roboto-Bold", size: 14)
        
        cell.MyProfileUniv.cornerRadius = 12
        
        cell.MyProfileCellContent.sizeToFit()
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        MyProfileCollectionView.backgroundColor = .none
        
        self.navigationController?.isNavigationBarHidden = true
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0 // cell사이의 간격 설정
        
        MyProfileCollectionView.collectionViewLayout = flowLayout
        
        MyProfileCollectionView.delegate = self
        MyProfileCollectionView.dataSource = self
        
        // HomeList = HomeServerAPI.boardsShowList() ?? []
        // print("MyProfile 서버통신 성공 및 원소 개수 ==  \(HomeList.count)")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        MyProfileCollectionView.setContentOffset(CGPoint(x: Int(self.view.frame.width) * startPage, y: 0), animated: true)
    }
        
}

extension MyProfile: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}



