//
//  GMSMapView+Rx.swift
//  RxGoogleMaps
//
//  Created by LeeSunhyoup on 2016. 7. 7..
//  Copyright © 2016년 Lee Sun-Hyoup. All rights reserved.
//

import GoogleMaps
import RxSwift
import RxCocoa

// Taken from RxCocoa until marked as public
func castOrThrow<T>(resultType: T.Type, _ object: AnyObject) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.CastingError(object: object, targetType: resultType)
    }
    return returnValue
}

extension GMSMapView {
    /**
     Reactive wrapper for `delegate`.
     
     For more information take a look at `DelegateProxyType` protocol documentation.
     */
    public var rx_delegate: DelegateProxy {
        return RxGMSMapViewDelegateProxy.proxyForObject(self)
    }
    
    // MARK: Observer Properties
    
    public var rx_selectedMarker: AnyObserver<GMSMarker?> {
        return UIBindingObserver(UIElement: self) { map, marker in
            map.selectedMarker = marker
        }.asObserver()
    }
    
    public var rx_zoom: AnyObserver<Float> {
        return UIBindingObserver(UIElement: self) { map, zoom in
            map.camera = GMSCameraPosition(
                target: map.camera.target,
                zoom: zoom,
                bearing: map.camera.bearing,
                viewingAngle: map.camera.viewingAngle
            )
        }.asObserver()
    }
    
    // MARK: Marker Events
    
    public var rx_didTapMarker: ControlEvent<GMSMarker> {
        let proxy = RxGMSMapViewDelegateProxy.proxyForObject(self)
        return proxy.didTapMarkerEvent
    }
    
    public var rx_didDragMarker: ControlEvent<GMSMarker> {
        let source = rx_delegate
            .observe(#selector(GMSMapViewDelegate.mapView(_:didDragMarker:)))
            .map { a in
                return try castOrThrow(GMSMarker.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    public var rx_didBeginDraggingMarker: ControlEvent<GMSMarker> {
        let source = rx_delegate
            .observe(#selector(GMSMapViewDelegate.mapView(_:didBeginDraggingMarker:)))
            .map { a in
                return try castOrThrow(GMSMarker.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    public var rx_didEndDraggingMarker: ControlEvent<GMSMarker> {
        let source = rx_delegate
            .observe(#selector(GMSMapViewDelegate.mapView(_:didEndDraggingMarker:)))
            .map { a in
                return try castOrThrow(GMSMarker.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    // MARK: Camera Events
    
    public var rx_willMove: ControlEvent<Bool> {
        let source = rx_delegate
            .observe(#selector(GMSMapViewDelegate.mapView(_:willMove:)))
            .map { a in
                return try castOrThrow(Bool.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    public var rx_didChangeCameraPosition: ControlEvent<GMSCameraPosition> {
        let source = rx_delegate
            .observe(#selector(GMSMapViewDelegate.mapView(_:didChangeCameraPosition:)))
            .map { a in
                return try castOrThrow(GMSCameraPosition.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    public var rx_idleAtCameraPosition: ControlEvent<GMSCameraPosition> {
        let source = rx_delegate
            .observe(#selector(GMSMapViewDelegate.mapView(_:idleAtCameraPosition:)))
            .map { a in
                return try castOrThrow(GMSCameraPosition.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    // MARK: User Interaction
    
    public var rx_didTapAtCoordinate: ControlEvent<CLLocationCoordinate2D> {
        let source = rx_delegate
            .observe(#selector(GMSMapViewDelegate.mapView(_:didTapAtCoordinate:)))
            .map { a in
                return try castOrThrow(CLLocationCoordinate2D.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    public var rx_didLongPressAtCoordinate: ControlEvent<CLLocationCoordinate2D> {
        let source = rx_delegate
            .observe(#selector(GMSMapViewDelegate.mapView(_:didLongPressAtCoordinate:)))
            .map { a in
                return try castOrThrow(CLLocationCoordinate2D.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    // MARK: Overlay Events
    
    public var rx_didTapOverlay: ControlEvent<GMSOverlay> {
        let source = rx_delegate
            .observe(#selector(GMSMapViewDelegate.mapView(_:didTapOverlay:)))
            .map { a in
                return try castOrThrow(GMSOverlay.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    // MARK: InfoWindow Events
    
    public var rx_didTapInfoWindowOfMarker: ControlEvent<GMSMarker> {
        let source = rx_delegate
            .observe(#selector(GMSMapViewDelegate.mapView(_:didTapInfoWindowOfMarker:)))
            .map { a in
                return try castOrThrow(GMSMarker.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    public var rx_didLongPressInfoWindowOfMarker: ControlEvent<GMSMarker> {
        let source = rx_delegate
            .observe(#selector(GMSMapViewDelegate.mapView(_:didLongPressInfoWindowOfMarker:)))
            .map { a in
                return try castOrThrow(GMSMarker.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    public var rx_didCloseInfoWindowOfMarker: ControlEvent<GMSMarker> {
        let source = rx_delegate
            .observe(#selector(GMSMapViewDelegate.mapView(_:didCloseInfoWindowOfMarker:)))
            .map { a in
                return try castOrThrow(GMSMarker.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    // MARK: MyLocationButton Event
    
    public var rx_didTapMyLocationButtonForMapView: ControlEvent<Void> {
        let proxy = RxGMSMapViewDelegateProxy.proxyForObject(self)
        return proxy.didTapMyLocationButtonForMapViewEvent
    }
    
    // MARK: Rendering Events
    
    public var rx_mapViewSnapshotReady: ControlEvent<Void> {
        let source = rx_delegate
            .observe(#selector(GMSMapViewDelegate.mapViewSnapshotReady(_:)))
            .map { _ in
                return
            }
        return ControlEvent(events: source)
    }
    
    public var rx_mapViewDidStartTileRendering: ControlEvent<Void> {
        let source = rx_delegate
            .observe(#selector(GMSMapViewDelegate.mapViewDidStartTileRendering(_:)))
            .map { _ in
                return
            }
        return ControlEvent(events: source)
    }
    
    public var rx_mapViewDidFinishTileRendering: ControlEvent<Void> {
        let source = rx_delegate
            .observe(#selector(GMSMapViewDelegate.mapViewDidFinishTileRendering(_:)))
            .map { _ in
                return
            }
        return ControlEvent(events: source)
    }
}