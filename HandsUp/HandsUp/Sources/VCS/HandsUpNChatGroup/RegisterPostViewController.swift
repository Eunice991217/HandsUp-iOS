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
    
    @IBOutlet weak var characterView_HVC: Character_UIView!
    
    @IBOutlet weak var characterViewWidth: NSLayoutConstraint!
    @IBOutlet weak var characterViewHeight: NSLayoutConstraint!
    
    @IBOutlet var locationLabel_HVC: UILabel!
    
    @IBOutlet var universityLabel_HVC: UILabel!
    
    @IBOutlet weak var characterViewHeight_HVC: NSLayoutConstraint!
    //tag btn 설정
    @IBOutlet weak var totalTagBtn_HVC: UIButton!
    
    @IBOutlet weak var totalScrollView_HVC: UIScrollView!
    @IBOutlet weak var msgTextView_HVC: UITextView!
    var textIsEmpty = true
    
    @IBOutlet var nameLB_HVC: UILabel!
    
    @IBOutlet weak var talkTagBtn_HVC: UIButton!
    @IBOutlet weak var foodTagBtn_HVC: UIButton!
    @IBOutlet weak var studyTagBtn_HVC: UIButton!
    @IBOutlet weak var hobbyTagBtn_HVC: UIButton!
    @IBOutlet weak var tripTagBtn_HVC: UIButton!
    
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
        
        self.timeLb_HVC.text = "12h"
        self.timeSlider_HVC.value = 12.0
        self.nameLB_HVC.text = UserDefaults.standard.string(forKey: "nickname")!
        
        msgTextView_HVC.delegate = self
        
        msgTextView_HVC.textColor =  UIColor.lightGray
        msgTextView_HVC.textContainerInset = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        
        
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
                
        
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        requestAuthorization()
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
        
            print("nil 이었음")

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
            let result = PostAPI.makeNewPost(indicateLocation: indicateLocation_HVC, latitude: latitude_HVC, longitude: longitude_HVC, content: content_HVC, tag: selectedTag_HVC, messageDuration: messageDuration_HVC)
            
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
    
    
    //tag 버튼 action 설정
    @IBAction func totalTagDidTap(_ sender: UIButton) {
            resetTagBtn()
            
            totalIsOn = true
            totalTagBtn_HVC.setTitleColor(clickedColor, for: .normal)
            selectedTag_HVC = "전체"
        
    }
    @IBAction func talkTagDidTap(_ sender: UIButton) {
            resetTagBtn()
            
            talkIsOn = true
            talkTagBtn_HVC.setTitleColor(clickedColor, for: .normal)
            selectedTag_HVC = "Talk"
    }
    @IBAction func foodTagDidTap(_ sender: UIButton) {
            resetTagBtn()
            foodTagBtn_HVC.setTitleColor(clickedColor, for: .normal)
            foodIsOn = true
            selectedTag_HVC = "밥"
    }
    @IBAction func studyTagDidTap(_ sender: UIButton) {
            resetTagBtn()
            studyTagBtn_HVC.setTitleColor(clickedColor, for: .normal)
            studyIsOn = true
            selectedTag_HVC = "스터디"

    }
    @IBAction func hobbyTagDidTap(_ sender: UIButton) {
        resetTagBtn()
        hobbyTagBtn_HVC.setTitleColor(clickedColor, for: .normal)
        hobbyIsOn = true
        selectedTag_HVC = "취미"
    }
    
    @IBAction func tripTagDidTap(_ sender: UIButton) {
        
        resetTagBtn()
        tripTagBtn_HVC.setTitleColor(clickedColor, for: .normal)
        tripIsOn = true
        selectedTag_HVC = "여행"
    }
    
    func resetTagBtn() {
        totalTagBtn_HVC.titleLabel?.textColor = unClickedColor
        talkTagBtn_HVC.titleLabel?.textColor = unClickedColor
        foodTagBtn_HVC.titleLabel?.textColor = unClickedColor
        studyTagBtn_HVC.titleLabel?.textColor = unClickedColor
        hobbyTagBtn_HVC.titleLabel?.textColor = unClickedColor
        tripTagBtn_HVC.titleLabel?.textColor = unClickedColor
        totalIsOn = false; talkIsOn = false; foodIsOn = false; studyIsOn = false; hobbyIsOn = false; tripIsOn = false
    }
    
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
    



