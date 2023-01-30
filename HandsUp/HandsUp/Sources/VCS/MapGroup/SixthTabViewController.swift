//
//  SixthTabViewController.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/16.
//

import UIKit

public let DEFAULT_POSITION6 = MTMapPointGeo(latitude: 37.55084892824633, longitude: 127.07551820008577)

class SixthTabViewController: UIViewController, MTMapViewDelegate {
    
    var mapView: MTMapView?
    
    var mapPoint1: MTMapPoint?
    var poiItem1: MTMapPOIItem?
    
    var mapPoint2: MTMapPoint?
    var poiItem2: MTMapPOIItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 지도 불러오기
        mapView = MTMapView(frame: self.view.bounds)
        
        if let mapView = mapView {
            mapView.delegate = self
            mapView.baseMapType = .standard
            
            // 지도 중심점, 레벨
            mapView.setMapCenter(MTMapPoint(geoCoord: DEFAULT_POSITION1), zoomLevel: 0, animated: true)
            
            // 현재 위치 트래킹
            //            mapView.showCurrentLocationMarker = true
            //            mapView.currentLocationTrackingMode = .onWithoutHeading
            
            // 마커 추가
            self.mapPoint1 = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.55084892824633, longitude: 127.07551820008577))
            self.mapPoint2 = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.54990522391498, longitude: 127.07466624750248))
            
            poiItem1 = MTMapPOIItem()
            poiItem1?.markerType = MTMapPOIItemMarkerType.customImage
            poiItem1?.customImageName = "characterExample4Small"
            poiItem1?.mapPoint = mapPoint1
            poiItem1?.itemName = "세종대학교 대양AI센터"
            mapView.add(poiItem1)
            
            poiItem2 = MTMapPOIItem()
            poiItem2?.markerType = MTMapPOIItemMarkerType.customImage
            poiItem2?.customImageName = "characterExample4Small"
            poiItem2?.mapPoint = mapPoint2
            poiItem2?.itemName = "세종대학교 광개토관"
            mapView.add(poiItem2)
            
            self.view.addSubview(mapView)
        }
        
    }
}
