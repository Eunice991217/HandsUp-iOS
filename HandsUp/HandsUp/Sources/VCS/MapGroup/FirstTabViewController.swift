//
//  FirstTabViewController.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/16.
//

import UIKit
import CoreLocation
import NMapsMap
import SnapKit

class FirstTabViewController: UIViewController, CLLocationManagerDelegate{
    
    var locationManager = CLLocationManager()
    let cameraPosition = NMFCameraPosition()
    let marker = NMFMarker()
    let markerEx = NMFMarker()
    var listMarker : [NMFMarker] = []
    var mapView: NMFMapView!
    
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
    
    @objc func restartDidTap() {
        listMarker.forEach {
            $0.mapView = nil
        }
        
        listMarker = []
        
        let charImg : Character_UIView = Character_UIView(frame:CGRect(x: 0, y: 0, width: 200, height: 200))
        let map_list = HomeServerAPI.showMapList()
        if map_list != nil{
            map_list?.forEach{
                let new_marker = NMFMarker()
                new_marker.position = NMGLatLng(lat: $0.latitude,lng: $0.longitude)
                charImg.convertSet(arr: $0.character)
                self.view.addSubview(charImg)
                new_marker.iconImage = NMFOverlayImage(image: charImg.asImage())
                charImg.removeFromSuperview()
                new_marker.width = 60
                new_marker.height = 60
                
                let storyboard: UIStoryboard? = UIStoryboard(name: "Main", bundle: Bundle.main)
                guard let MyProfileView = storyboard?.instantiateViewController(identifier: "MyProfileView") else {
                    return
                }
                MyProfileView.modalPresentationStyle = .overFullScreen
                
                let boardIndex = Int64($0.boardIdx)
                
                new_marker.touchHandler = { (overlay: NMFOverlay) -> Bool in
                    if let MyProfileView = MyProfileView as? MyProfileView {
                        MyProfileView.boardIndex = boardIndex
                        self.present(MyProfileView, animated: true)
                    }
                    return true // 이벤트 소비, -mapView:didTapMap:point 이벤트는 발생하지 않음
                }
                
                new_marker.mapView = mapView
                listMarker.append(new_marker)
            }
        }
    }
    
    @objc func SearchMP() {
        // 내 위치 가져오기
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // 위도, 경도 가져오기
        let latitude = locationManager.location?.coordinate.latitude ?? 0
        let longitude = locationManager.location?.coordinate.longitude ?? 0
        print(latitude)
        print(longitude)
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude, lng: longitude), zoomTo: 15.0)
        mapView.moveCamera(cameraUpdate)
        cameraUpdate.animation = .easeIn
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        mapView = NMFMapView(frame: view.frame)
        mapView.allowsZooming = true // 줌 가능
        mapView.allowsScrolling = true // 스크롤 가능
        mapView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 110, right: 0) // 컨텐츠 패딩값 (하단 탭바만큼 패딩값)
        view.addSubview(mapView)
        
        view.addSubview(MyPosition)
        view.addSubview(MapReset)
        
        MapReset.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        MyPosition.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-96)
        }
        
        MapReset.addTarget(self, action: #selector(restartDidTap), for: .touchUpInside)
        MyPosition.addTarget(self, action: #selector(SearchMP), for: .touchUpInside)
        
        // 내 위치 가져오기
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // 위도, 경도 가져오기
        let latitude = locationManager.location?.coordinate.latitude ?? 0
        let longitude = locationManager.location?.coordinate.longitude ?? 0
        print(latitude)
        print(longitude)
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude, lng: longitude), zoomTo: 15.0)
        mapView.moveCamera(cameraUpdate)
        cameraUpdate.animation = .easeIn
        
        let charImg : Character_UIView = Character_UIView(frame:CGRect(x: 0, y: 0, width: 200, height: 200))
        let map_list = HomeServerAPI.showMapList()
        if map_list != nil{
            map_list?.forEach{
                let new_marker = NMFMarker()
                new_marker.position = NMGLatLng(lat: $0.latitude,lng: $0.longitude)
                charImg.convertSet(arr: $0.character)
                self.view.addSubview(charImg)
                new_marker.iconImage = NMFOverlayImage(image: charImg.asImage())
                charImg.removeFromSuperview()
                new_marker.width = 60
                new_marker.height = 60
                
                let storyboard: UIStoryboard? = UIStoryboard(name: "Main", bundle: Bundle.main)
                guard let MyProfileView = storyboard?.instantiateViewController(identifier: "MyProfileView") else {
                    return
                }
                MyProfileView.modalPresentationStyle = .overFullScreen
                
                let boardIndex = Int64($0.boardIdx)
                
                new_marker.touchHandler = { (overlay: NMFOverlay) -> Bool in
                    if let MyProfileView = MyProfileView as? MyProfileView {
                        MyProfileView.boardIndex = boardIndex
                        self.present(MyProfileView, animated: true)
                    }
                    return true // 이벤트 소비, -mapView:didTapMap:point 이벤트는 발생하지 않음
                }
                
                new_marker.mapView = mapView
                listMarker.append(new_marker)
            }
        }
        
    }
    
}

