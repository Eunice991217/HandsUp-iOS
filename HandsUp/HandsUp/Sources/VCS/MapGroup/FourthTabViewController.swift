//
//  FourthTabViewController.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/16.
//

import UIKit
import CoreLocation
import NMapsMap
import SnapKit

class FourthTabViewController: UIViewController, CLLocationManagerDelegate{
    
    lazy var MyPosition: UIButton = {
        let MPbtn = UIButton()
        MPbtn.setImage(UIImage(named: "FilterCenterFocus"), for: .normal)
        return MPbtn
    }()
    
    lazy var MapReset: UIButton = {
        let MPbtn = UIButton()
        MPbtn.setImage(UIImage(named: "mapResearch"), for: .normal)
        return MPbtn
    }()
    
    lazy var restart: UIButton = {
        let MPbtn = UIButton()
        MPbtn.setImage(UIImage(named: "restart"), for: .normal)
        return MPbtn
    }()

    var locationManager = CLLocationManager()
    let cameraPosition = NMFCameraPosition()
    let marker = NMFMarker()
    
    @objc func restartDidTap() {
        viewDidLoad()
    }
    
    @objc func SearchMP() {
        viewDidLoad()
    }
    
    override func viewDidLoad() {
        
        //        let cameraPosition = mapView.cameraPosition // 현재 위치를 얻는 예제
        //        print(cameraPosition)
        
        super.viewDidLoad()
        
        let mapView = NMFMapView(frame: view.frame)
        mapView.allowsZooming = true // 줌 가능
        mapView.allowsScrolling = true // 스크롤 가능
        view.addSubview(mapView)

        view.addSubview(MyPosition)
        view.addSubview(MapReset)
        MapReset.addSubview(restart)
        
        restart.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalToSuperview().offset(130)
            //make.center.equalToSuperview()
        }
        
        MapReset.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }

        MyPosition.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-96)
        }
        
        // 지정한 위치로 카메라 이동
        let cameraSet = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 37.67151516118892, lng: 127.07768966850527))
        cameraSet.animation = .easeIn
        mapView.moveCamera(cameraSet)
        // print(cameraSet)
        
        MapReset.addTarget(self, action: #selector(restartDidTap), for: .touchUpInside)
        MyPosition.addTarget(self, action: #selector(SearchMP), for: .touchUpInside)
        
//        // 내 위치 가져오기
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//
//        // 위도, 경도 가져오기
//        let latitude = locationManager.location?.coordinate.latitude ?? 0
//        let longitude = locationManager.location?.coordinate.longitude ?? 0
//        print(latitude)
//        print(longitude)
//
//        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude, lng: longitude), zoomTo: 8)
//        mapView.moveCamera(cameraUpdate)
//        cameraUpdate.animation = .easeIn
       
        // 마커 추가
        marker.position = NMGLatLng(lat: 37.67151516118892, lng: 127.07768966850527)
        marker.iconImage = NMFOverlayImage(name: "characterExample4")
        marker.width = 60
        marker.height = 60
        
        let storyboard: UIStoryboard? = UIStoryboard(name: "Main", bundle: Bundle.main)

        // 스토리보드에서 지정해준 ViewController의 ID
        guard let myProfile = storyboard?.instantiateViewController(identifier: "MyProfile") else {
            return
        }

        myProfile.modalPresentationStyle = .overFullScreen

        marker.touchHandler = { (overlay: NMFOverlay) -> Bool in
            self.present(myProfile, animated: true)
            return true // 이벤트 소비, -mapView:didTapMap:point 이벤트는 발생하지 않음
        }
        
        mapView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0) // 컨텐츠 패딩값 (하단 탭바만큼 패딩값)

        marker.mapView = mapView
        
        // Do any additional setup after loading the view.
    }
    
}

// 위도, 경도를 화면 좌표로 바꿔줌
//        let projection = mapView.projection
//        let point = projection.point(from: NMGLatLng(lat: 37.36247139001076, lng: 127.10519331440649))
//        print(point) // 출력
