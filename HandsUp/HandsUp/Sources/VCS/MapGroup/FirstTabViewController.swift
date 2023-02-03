//
//  FirstTabViewController.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/16.
//

import UIKit
import CoreLocation
import NMapsMap

class FirstTabViewController: UIViewController, CLLocationManagerDelegate{

    var locationManager = CLLocationManager()
    let marker = NMFMarker()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapView = NMFMapView(frame: view.frame)
        view.addSubview(mapView)
        
        marker.position = NMGLatLng(lat: 37.36247139001076, lng: 127.10519331440649)
        marker.iconImage = NMFOverlayImage(name: "characterExample4")
        marker.width = 60
        marker.height = 60
        
        marker.touchHandler = { (overlay: NMFOverlay) -> Bool in
            //guard let myProfile = self.storyboard?.instantiateViewController(withIdentifier: "MyProfile") else {return}
            //myProfile.modalPresentationStyle = .overFullScreen
            //self.present(myProfile, animated: true, completion:nil)
            print("마커 터치")
            return true // 이벤트 소비, -mapView:didTapMap:point 이벤트는 발생하지 않음
        }
        
        

        
        marker.mapView = mapView
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
        
}

