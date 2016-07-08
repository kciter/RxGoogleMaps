//
//  ViewController.swift
//  RxGoogleMaps-Sample
//
//  Created by LeeSunhyoup on 2016. 7. 8..
//  Copyright © 2016년 Lee Sun-Hyoup. All rights reserved.
//

import UIKit
import GoogleMaps
import RxSwift
import RxCocoa
//import RxGoogleMaps

class ViewController: UIViewController {
    var mapView: GMSMapView!
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = GMSMapView(frame: UIScreen.mainScreen().bounds)
        view.addSubview(mapView)
        
        let marker = GMSMarker(position: mapView.camera.target)
        marker.map = mapView
        marker.draggable = true
        
        bindToRx()
    }
    
    func bindToRx() {
        mapView.rx_willMove
            .asDriver()
            .driveNext { gesture in
                print("Will Move")
            }.addDisposableTo(disposeBag)
        
        mapView.rx_didChangeCameraPosition
            .asDriver()
            .driveNext { cameraPosition in
                print(cameraPosition)
                print("Did Change Camera Postion")
            }.addDisposableTo(disposeBag)
        
        mapView.rx_didTapMarker
            .asDriver()
            .driveNext { marker in
                print(marker.position)
                print("Did Marker Tap")
            }.addDisposableTo(disposeBag)
    }
}

