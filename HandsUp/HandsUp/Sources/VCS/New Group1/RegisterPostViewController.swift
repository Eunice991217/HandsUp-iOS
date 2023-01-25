//
//  asViewController.swift
//  HandsUp
//
//  Created by 윤지성 on 2023/01/19.
//

import UIKit
import CoreLocation

class RegisterPostViewController: UIViewController {

    // 위치정보를 가져오기 위한 locationManager
    var locationManager_HVC: CLLocationManager!
    
    @IBOutlet weak var profileImgViewHeight: NSLayoutConstraint!
    //tag btn 설정
    @IBOutlet weak var totalTagBtn_HVC: UIButton!
    
    @IBOutlet weak var totalScrollView_HVC: UIScrollView!
    @IBOutlet weak var msgTextView_HVC: UITextView!
    
    @IBOutlet weak var talkTagBtn_HVC: UIButton!
    @IBOutlet weak var foodTagBtn_HVC: UIButton!
    @IBOutlet weak var studyTagBtn_HVC: UIButton!
    @IBOutlet weak var hobbyTagBtn_HVC: UIButton!
    @IBOutlet weak var tripTagBtn_HVC: UIButton!
    
    @IBOutlet weak var tagScrollView_HVC: TagScrollView!
    @IBOutlet weak var borderLine_HVC: UIView!
    
    @IBOutlet weak var timeLb_HVC: UILabel!
    @IBOutlet weak var timeSlider_HVC: UISlider!
    @IBOutlet weak var sendBtn_HVC: UIButton!
    
    var totalIsOn = false; var talkIsOn = false; var foodIsOn = false; var studyIsOn = false; var hobbyIsOn = false;var tripIsOn = false;
    let unClickedColor = UIColor(named: "HandsUpLightGrey")
    let clickedColor = UIColor(named: "HandsUpOrange")
    
    @IBAction func CancelBtnDidTap(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        locationManager_HVC = CLLocationManager()
        // 델리게이트를 설정하고,
        locationManager_HVC.delegate = self
        
        locationManager_HVC.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        locationManager_HVC.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            print("위치상태 on!")
            locationManager_HVC.startUpdatingLocation()
            
            print(locationManager_HVC.location?.coordinate)
            
        }else{
            print("위치상태 off!")
        }
        
        borderLine_HVC.backgroundColor =  UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        sendBtn_HVC.layer.cornerRadius = 10
        
        self.timeLb_HVC.text = "1h"
        
        
        msgTextView_HVC.delegate = self
                
        //처음 화면이 로드되었을 때 플레이스 홀더처럼 보이게끔 만들어주기
        msgTextView_HVC.text = "메세지를 입력해주세요!"
        msgTextView_HVC.textColor = UIColor.lightGray
        
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
    
    @objc func keyboardUp(notification:NSNotification) {
            UIView.animate(
                withDuration: 0.3
                , animations: {
                    self.profileImgViewHeight.constant = 0.0
                }
            )
        
    }
    
    @objc func keyboardDown() {
        self.profileImgViewHeight.constant = 145.0
    }
    
  
    
    //화면 터치하면 키보드 사라지는 함수 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

         self.view.endEditing(true)
   }
    
    @objc func MyTapMethod(sender: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
    }
    
    @IBAction func locationSwitchBtnDidTap(_ sender: Any) {
        
        
    }
    
    
    @IBAction func timeChangeDidChange(_ sender: UISlider) {
        let step: Float = 1
        let timeValue = round(sender.value / step) * step
        sender.value = timeValue
        
        self.timeLb_HVC.text = String(Int(timeValue)) + "h"
    }
   
    
    //'핸즈업 올리기' 버튼 action method
    @IBAction func sendBtnDidTap(_ sender: Any) {
        
        
        self.presentingViewController?.dismiss(animated: true)
        
    }
    
    
    //tag 버튼 action 설정
    @IBAction func totalTagDidTap(_ sender: UIButton) {
        if(totalIsOn){
           totalIsOn = false
            totalTagBtn_HVC.setTitleColor(unClickedColor, for: .normal)
        }else{
            resetTagBtn()
            
            totalIsOn = true
            totalTagBtn_HVC.setTitleColor(clickedColor, for: .normal)
        }
    }
    @IBAction func talkTagDidTap(_ sender: UIButton) {
        if(talkIsOn){
            talkIsOn = false
            talkTagBtn_HVC.setTitleColor(unClickedColor, for: .normal)
        }else{
            resetTagBtn()
           
            talkIsOn = true
            talkTagBtn_HVC.setTitleColor(clickedColor, for: .normal)
        }
    }
    @IBAction func foodTagDidTap(_ sender: UIButton) {
        if(foodIsOn){
            foodIsOn = false
            foodTagBtn_HVC.setTitleColor(unClickedColor, for: .normal)
        }else{
            resetTagBtn()
           foodTagBtn_HVC.setTitleColor(clickedColor, for: .normal)
            foodIsOn = true

        }
    }
    @IBAction func studyTagDidTap(_ sender: UIButton) {
        if(studyIsOn){
            studyIsOn = false
            studyTagBtn_HVC.setTitleColor(unClickedColor, for: .normal)
        }else{
            resetTagBtn()
            studyTagBtn_HVC.setTitleColor(clickedColor, for: .normal)
            studyIsOn = true

        }
    }
    @IBAction func hobbyTagDidTap(_ sender: UIButton) {
        if(hobbyIsOn){
            hobbyIsOn = false
            hobbyTagBtn_HVC.setTitleColor(unClickedColor, for: .normal)
        }else{
            resetTagBtn()
            hobbyTagBtn_HVC.setTitleColor(clickedColor, for: .normal)
            hobbyIsOn = true
        }
    }
    
    @IBAction func tripTagDidTap(_ sender: UIButton) {
        if(tripIsOn){
            tripIsOn = false
            tripTagBtn_HVC.setTitleColor(unClickedColor, for: .normal)
        }else{
            resetTagBtn()
            tripTagBtn_HVC.setTitleColor(clickedColor, for: .normal)
            tripIsOn = true
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
    }

}

extension RegisterPostViewController : UITextViewDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
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

extension RegisterPostViewController:CLLocationManagerDelegate{
    
    private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("did update location")
            if let location = locations.first {
                print("위도: \(location.coordinate.latitude)")
                print("경도: \(location.coordinate.longitude)")
            }
        }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("에러입니다.")
    }
}

extension RegisterPostViewController:UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView){

            self.view.endEditing(true)

        }
}
    



