//
//  asViewController.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/01/19.
//

import UIKit
import CoreLocation
import Alamofire
import MapKit

class RegisterPostViewController: UIViewController{
    var isEdited: Bool = false
    var boardIdx: Int = 0
    
    
    @IBOutlet weak var characterView_HVC: Character_UIView!
    
    @IBOutlet weak var characterViewWidth: NSLayoutConstraint!
    @IBOutlet weak var characterViewHeight: NSLayoutConstraint!
    
    @IBOutlet var locationLabel_HVC: UILabel!
    @IBOutlet var universityLabel_HVC: UILabel!
    
    @IBOutlet weak var characterViewHeight_HVC: NSLayoutConstraint!
    //tag btn 설정
    @IBOutlet weak var totalTagBtn_HVC: CustomTagBtn!
    
    @IBOutlet weak var totalScrollView_HVC: UIScrollView!
    @IBOutlet weak var msgTextView_HVC: UITextView!
    var textIsEmpty = true
    
    @IBOutlet var nameLB_HVC: UILabel!
    
    @IBOutlet weak var talkTagBtn_HVC: CustomTagBtn!
    @IBOutlet weak var foodTagBtn_HVC: CustomTagBtn!
    @IBOutlet weak var studyTagBtn_HVC: CustomTagBtn!
    @IBOutlet weak var hobbyTagBtn_HVC: CustomTagBtn!
    @IBOutlet weak var tripTagBtn_HVC: CustomTagBtn!
    
    var indicateLocation_HVC = "true"
    var selectedTag_HVC = "전체"
    var messageDuration_HVC = 12
    var content_HVC = ""
    var longitude_HVC = 0.0
    var latitude_HVC = 0.0
    
    @IBOutlet weak var tagScrollView_HVC: TagScrollView!
    @IBOutlet weak var borderLine_HVC: UIView!
    
    
    @IBOutlet var locationSwitchBtn_HVC: CustomSwitch!
    
    @IBOutlet weak var timeLb_HVC: UILabel!
    @IBOutlet weak var timeSlider_HVC: UISlider!
    @IBOutlet weak var sendBtn_HVC: UIButton!
    
    var totalIsOn = false; var talkIsOn = false; var foodIsOn = false; var studyIsOn = false; var hobbyIsOn = false;var tripIsOn = false;
    let unClickedColor = UIColor(named: "HandsUpLightGrey")
    let clickedColor = UIColor(named: "HandsUpOrange")
    
    @IBAction func CancelBtnDidTap(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    //LocationManager 선언
    let locationManager = CLLocationManager()
    var currentLocation:CLLocationCoordinate2D!
    
    var findLocation:CLLocation!
    let geocoder = CLGeocoder()
    let locale = Locale(identifier: "Ko-kr") //원하는 언어의 나라 코드를 넣어주시면 됩니다.
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        borderLine_HVC.backgroundColor =  UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        sendBtn_HVC.layer.cornerRadius = 10
        
        totalTagBtn_HVC.text = "전체"; talkTagBtn_HVC.text = "Talk"; foodTagBtn_HVC.text = "밥"; studyTagBtn_HVC.text = "스터디"; hobbyTagBtn_HVC.text = "취미"; tripTagBtn_HVC.text = "여행";
        totalTagBtn_HVC.addTarget(self,action:#selector(tagBtnDidTap),
                                  for:.touchUpInside)
        talkTagBtn_HVC.addTarget(self,action:#selector(tagBtnDidTap),
                                 for:.touchUpInside)
        foodTagBtn_HVC.addTarget(self,action:#selector(tagBtnDidTap),
                                 for:.touchUpInside)
        studyTagBtn_HVC.addTarget(self,action:#selector(tagBtnDidTap),
                                  for:.touchUpInside)
        hobbyTagBtn_HVC.addTarget(self,action:#selector(tagBtnDidTap),
                                  for:.touchUpInside)
        tripTagBtn_HVC.addTarget(self,action:#selector(tagBtnDidTap),
                                 for:.touchUpInside)
        
        self.nameLB_HVC.text = UserDefaults.standard.string(forKey: "nickname")!
        
        msgTextView_HVC.delegate = self
        msgTextView_HVC.textContainerInset = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        print("boardidx: \(boardIdx)")
        let editedBoard = ServerAPI.singleList(boardIdx: boardIdx)
        //게시물 수정 시
        if(isEdited == true){
            self.msgTextView_HVC.text = editedBoard!.content
            self.content_HVC = editedBoard!.content
            self.textIsEmpty = false
            self.timeLb_HVC.text = String(editedBoard!.messageDuration )
            self.timeSlider_HVC.value = Float(editedBoard!.messageDuration)
            self.sendBtn_HVC.backgroundColor = UIColor(named: "HandsUpOrange")
            self.selectedTag_HVC = editedBoard!.tag
            
            
            if(editedBoard?.locationAgreement == "false"){
                print("게시물 수정하는데 위치 ")
                self.indicateLocation_HVC = "false"
                locationSwitchBtn_HVC.isOn = false
                locationSwitchBtn_HVC.setupUI()
                self.locationLabel_HVC.text = "위치 비밀"
            }
        }
        else{
            msgTextView_HVC.textColor =  UIColor.lightGray
            self.timeLb_HVC.text = "12h"
            self.timeSlider_HVC.value = 12.0
            requestAuthorization()
        }
        resetTagBtn()
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.msgTextView_HVC.resignFirstResponder()
        }
        let xUnit = tagScrollView_HVC.bounds.width
        
        tagScrollView_HVC.contentSize.width = xUnit * 10
        tagScrollView_HVC.canCancelContentTouches = true
        
        //scrollview에서 터치했을 때 키보드가 내려가게 함
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MyTapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        totalScrollView_HVC.addGestureRecognizer(singleTapGestureRecognizer)
        
        
        characterView_HVC.setUserCharacter()
        
        
        var schoolName = UserDefaults.standard.string(forKey: "schoolName")!
        var cutSchoolName = ""
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
        
        self.universityLabel_HVC.text = cutSchoolName
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 옵져버를 등록
        // 옵저버 대상 self
        // 옵져버 감지시 실행 함수
        // 옵져버가 감지할 것
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func requestAuthorization() {

            //정확도를 검사한다.
            //locationManager!.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            //앱을 사용할때 권한요청
            
            
            switch locationManager.authorizationStatus {
            case .restricted, .denied:
                print("restricted n denied")
                locationManager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse, .authorizedAlways:
                print("권한있음")
                locationManagerDidChangeAuthorization(locationManager)
            default:
                locationManager.startUpdatingLocation()
                print("default")
            }
            
            locationManagerDidChangeAuthorization(locationManager)
            getAddressByLocation()
            
            if(latitude_HVC == 0.0 || longitude_HVC == 0.0){
                self.locationLabel_HVC.text = "위치를 가져올 수 없습니다."
            }
            else{
                getAddressByLocation()
            }
        
    }
    
    private func getAddressByLocation(){
        findLocation = CLLocation(latitude: latitude_HVC, longitude: longitude_HVC)
        if findLocation != nil {
            var address = ""
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
                self.locationLabel_HVC.text = address
                print(address) //서울특별시 광진구 중곡동 272-13
            }
        }
        
    }
    
    @objc func keyboardUp(notification:NSNotification) {
        UIView.animate(
            withDuration: 0.3
            , animations: {
                self.characterViewWidth.constant = 0
                self.characterViewHeight.constant = 0
                self.characterView_HVC.isHidden = true
                print("키보드 올라감")
            }
        )
    }
    
    @objc func keyboardDown() {
        self.characterViewWidth.constant = 145
        self.characterViewHeight.constant = 145
        self.characterView_HVC.isHidden = false
    }
    
    
    
    //화면 터치하면 키보드 사라지는 함수
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        self.view.endEditing(true)
    }
    
    @objc func MyTapMethod(sender: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
    }
    
    @IBAction func locationSwitchBtnDidTap(_ sender: Any) {
        if(locationSwitchBtn_HVC.isOn){
            indicateLocation_HVC = "true"
            requestAuthorization()
        }else{
            self.locationLabel_HVC.text = "위치 비밀"
            indicateLocation_HVC = "false"
        }
        
    }
    
    
    @IBAction func timeChangeDidChange(_ sender: UISlider) {
        let step: Float = 1
        let timeValue = round(sender.value / step) * step
        sender.value = timeValue
        
        messageDuration_HVC = Int(timeValue)
        
        self.timeLb_HVC.text = String(Int(timeValue)) + "h"
    }
    
    
    //'핸즈업 올리기' 버튼 action method
    @IBAction func sendBtnDidTap(_ sender: Any) {
        //위치 정보 표시할 때
        if(!textIsEmpty){
            content_HVC = msgTextView_HVC.text
            var result: Int!
            
            if(isEdited == true){ //수정하는 글일 시에 수정 API 요청
                result = PostAPI.editPost(indicateLocation: indicateLocation_HVC, latitude: latitude_HVC, longitude: longitude_HVC, content: content_HVC, tag: selectedTag_HVC, messageDuration: messageDuration_HVC, boardIdx: boardIdx, location : locationLabel_HVC.text!)
            }
            else{
                result = PostAPI.makeNewPost(indicateLocation: indicateLocation_HVC, latitude: latitude_HVC, longitude: longitude_HVC, content: content_HVC, tag: selectedTag_HVC, messageDuration: messageDuration_HVC, location : locationLabel_HVC.text!)
            }
            
            print("locationLabel_HVC.text : \(locationLabel_HVC.text!)")
            print("result:  \(result)")
            switch result {
            case 2000:
                
                self.presentingViewController?.dismiss(animated: true)
            case -1:
                ServerError()
            default:
                print("게시물 등록에 실패하였습니다.")
   
            }
        }
        
    }
    
    
    @objc func tagBtnDidTap(_ sender: CustomTagBtn) {
        resetTagBtn()
        
        switch sender.text{
        case "전체":
            totalIsOn = true
            totalTagBtn_HVC.setTitleColor(clickedColor, for: .normal)
            selectedTag_HVC = "전체"
            break
            
        case "Talk":
            talkIsOn = true
            talkTagBtn_HVC.setTitleColor(clickedColor, for: .normal)
            selectedTag_HVC = "Talk"
            break
            
        case "밥":
            foodTagBtn_HVC.setTitleColor(clickedColor, for: .normal)
            foodIsOn = true
            selectedTag_HVC = "밥"
            break
            
        case "스터디":
            studyTagBtn_HVC.setTitleColor(clickedColor, for: .normal)
            studyIsOn = true
            selectedTag_HVC = "스터디"
            break
            
        case "취미":
            hobbyTagBtn_HVC.setTitleColor(clickedColor, for: .normal)
            hobbyIsOn = true
            selectedTag_HVC = "취미"
            break
            
        case "여행":
            tripTagBtn_HVC.setTitleColor(clickedColor, for: .normal)
            tripIsOn = true
            selectedTag_HVC = "여행"
            break
            
        default:
            break
        }
   
    }
    func resetTagBtn() {
        totalTagBtn_HVC.titleLabel?.textColor = unClickedColor
        talkTagBtn_HVC.titleLabel?.textColor = unClickedColor
        foodTagBtn_HVC.titleLabel?.textColor = unClickedColor
        studyTagBtn_HVC.titleLabel?.textColor = unClickedColor
        hobbyTagBtn_HVC.titleLabel?.textColor = unClickedColor
        tripTagBtn_HVC.titleLabel?.textColor = unClickedColor
        totalIsOn = false; talkIsOn = false; foodIsOn = false; studyIsOn = false; hobbyIsOn = false; tripIsOn = false
        

            switch selectedTag_HVC{
            case "전체":
                totalIsOn = true
                totalTagBtn_HVC.setTitleColor(clickedColor, for: .normal)
                break
                
            case "Talk":
                talkIsOn = true
                talkTagBtn_HVC.setTitleColor(clickedColor, for: .normal)
                break
                
            case "밥":
                foodTagBtn_HVC.setTitleColor(clickedColor, for: .normal)
                foodIsOn = true
                break
                
            case "스터디":
                studyTagBtn_HVC.setTitleColor(clickedColor, for: .normal)
                studyIsOn = true
                break
                
            case "취미":
                hobbyTagBtn_HVC.setTitleColor(clickedColor, for: .normal)
                hobbyIsOn = true
                break
                
            case "여행":
                tripTagBtn_HVC.setTitleColor(clickedColor, for: .normal)
                tripIsOn = true
                break
                
            default:
                break
            }
    }
    
}

class CustomTagBtn: UIButton {
    var text: String?
}

extension RegisterPostViewController : UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = msgTextView_HVC.text ?? ""
        guard let stringRange = Range(range, in: currentText)else { return false}
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        let text_count = changedText.count

        // textview에 입력된 글자가 없을 때 입력 버튼 숨기기
        if(text_count > 0){
            sendBtn_HVC.backgroundColor = UIColor(named: "HandsUpOrange")
            textIsEmpty = false
        }
        else if (text_count == 0){
            sendBtn_HVC.backgroundColor = UIColor(named: "HandsUpWhiteGrey")
            textIsEmpty = true
        }
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView)  {
        if msgTextView_HVC.text.isEmpty {
            msgTextView_HVC.text =  "메세지를 입력해주세요!"
            msgTextView_HVC.textColor = UIColor.lightGray
        }
   
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if msgTextView_HVC.textColor == UIColor.lightGray {
            msgTextView_HVC.text = nil
            msgTextView_HVC.textColor = UIColor.black

        }
    }
}

class TagScrollView: UIScrollView{
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIButton {
          return true
        }
        return super.touchesShouldCancel(in: view)
      }
}




extension RegisterPostViewController:UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView){

            self.view.endEditing(true)

        }
}

extension RegisterPostViewController:CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            if let currentLocation = locationManager.location?.coordinate{
                print("coordinate")
                longitude_HVC = currentLocation.longitude
                latitude_HVC = currentLocation.latitude
            }
  
        }
        else{
            print("else")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            latitude_HVC =  location.coordinate.latitude
            longitude_HVC = location.coordinate.longitude
        }
    }

}
    



