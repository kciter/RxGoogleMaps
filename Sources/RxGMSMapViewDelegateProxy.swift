//
//  RxGMSMapViewDelegateProxy.swift
//  RxGoogleMaps
//
//  Created by LeeSunhyoup on 2016. 7. 7..
//  Copyright © 2016년 Lee Sun-Hyoup. All rights reserved.
//

import GoogleMaps
import RxSwift
import RxCocoa

class RxGMSMapViewDelegateProxy: DelegateProxy, GMSMapViewDelegate, DelegateProxyType {
    private let didTapMarkerSubject = PublishSubject<GMSMarker>()
    private let didTapMyLocationButtonForMapViewSubject = PublishSubject<Void>()
    
    let didTapMarkerEvent: ControlEvent<GMSMarker>
    let didTapMyLocationButtonForMapViewEvent: ControlEvent<Void>
    
    required init(parentObject: AnyObject) {
        didTapMarkerEvent = ControlEvent(events: didTapMarkerSubject)
        didTapMyLocationButtonForMapViewEvent = ControlEvent(events: didTapMyLocationButtonForMapViewSubject)
        
        super.init(parentObject: parentObject)
    }
    
    class func currentDelegateFor(object: AnyObject) -> AnyObject? {
        let mapView: GMSMapView = (object as? GMSMapView)!
        return mapView.delegate
    }
    
    class func setCurrentDelegate(delegate: AnyObject?, toObject object: AnyObject) {
        let mapView: GMSMapView = (object as? GMSMapView)!
        mapView.delegate = delegate as? GMSMapViewDelegate
    }
    
    func mapView(mapView: GMSMapView, didTapMarker marker: GMSMarker) -> Bool {
        didTapMarkerSubject.on(.Next(marker))
        return self._forwardToDelegate?.mapView?(mapView, didTapMarker: marker) ?? false
    }
    
    func didTapMyLocationButtonForMapView(mapView: GMSMapView) -> Bool {
        didTapMyLocationButtonForMapViewSubject.on(.Next())
        return self._forwardToDelegate?.didTapMyLocationButtonForMapView?(mapView) ?? true
    }
}