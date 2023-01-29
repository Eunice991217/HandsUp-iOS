//
//  FourthTabViewController.swift
//  HandsUp
//
//  Created by 김민경 on 2023/01/16.
//

import UIKit

class FourthTabViewController: UIViewController, MTMapViewDelegate {

    var mapView: MTMapView?

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MTMapView(frame: self.view.bounds)

        if let mapView = mapView {
            mapView.delegate = self
            mapView.baseMapType = .standard
            self.view.addSubview(mapView)
        }
    }

}
