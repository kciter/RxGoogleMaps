//
//  GMSMarker+Rx.swift
//  RxGoogleMaps
//
//  Created by LeeSunhyoup on 2016. 7. 8..
//  Copyright © 2016년 Lee Sun-Hyoup. All rights reserved.
//

import GoogleMaps
import RxSwift
import RxCocoa

extension GMSMarker {
    
    // MARK: Observer Properties
    
    public var rx_map: AnyObserver<GMSMapView> {
        return UIBindingObserver(UIElement: self) { marker, map in
            marker.map = map
        }.asObserver()
    }
    
    public var rx_icon: AnyObserver<UIImage?> {
        return UIBindingObserver(UIElement: self) { marker, icon in
            marker.icon = icon
        }.asObserver()
    }
    
    public var rx_position: AnyObserver<CLLocationCoordinate2D> {
        return UIBindingObserver(UIElement: self) { marker, position in
            marker.position = position
        }.asObserver()
    }
}