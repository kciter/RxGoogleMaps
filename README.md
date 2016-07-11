# RxGoogleMaps
RxGoogleMaps is a [RxSwift](https://github.com/ReactiveX/RxSwift) wrapper for [GoogleMaps](https://developers.google.com/maps/documentation/ios-sdk/start) delegate.

## Example
```swift
mapView = GMSMapView(frame: UIScreen.mainScreen().bounds)
view.addSubview(mapView)

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
```

## Requirements
* iOS 8.0+
* Swift 2.2+

## Installation
* **CocoaPods**
  <br>GoogleMaps is static libarary and CocoaPods doesn't support to static library...<br>So normally it can't be used. But, if you want to use CocoaPods, see below.
  ```ruby
  # Podfile Sample
  target 'Your-App' do
    use_frameworks!
    pod 'RxGoogleMaps', :git => 'https://github.com/kciter/RxGoogleMaps', :branch => "master"
  end

  Pod::Installer.class_eval { def verify_no_static_framework_transitive_dependencies; end }

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      if target.name.eql?("Your-App")
        puts "Removing GoogleMaps in #{target.name} OTHER_LDFLAGS"
        target.build_configurations.each do |config|
          xcconfig_path = config.base_configuration_reference.real_path
          xcconfig = File.read(xcconfig_path)
          File.open(xcconfig_path, "w") { |file| file << xcconfig.sub('-framework "GoogleMaps"', '') }
        end
      end
    end
  end
  ```
  It's very difficult. I recommend that you manually install.

* **Manually**
  <br>To install manually the RxGoogleMaps in an app, just drag the `Sources/*.swift` file into your project.

## Support
### `GMSMapView+Rx`
```swift
// MARK: Observer Properties
public var rx_selectedMarker: AnyObserver<GMSMarker?>
public var rx_zoom: AnyObserver<Float>

// MARK: Marker Events
public var rx_didTapMarker: ControlEvent<GMSMarker>
public var rx_didDragMarker: ControlEvent<GMSMarker>
public var rx_didBeginDraggingMarker: ControlEvent<GMSMarker>
public var rx_didEndDraggingMarker: ControlEvent<GMSMarker>

// MARK: Camera Events
public var rx_willMove: ControlEvent<Bool>
public var rx_didChangeCameraPosition: ControlEvent<GMSCameraPosition>
public var rx_idleAtCameraPosition: ControlEvent<GMSCameraPosition>

// MARK: User Interaction
public var rx_didTapAtCoordinate: ControlEvent<CLLocationCoordinate2D>
public var rx_didLongPressAtCoordinate: ControlEvent<CLLocationCoordinate2D>

// MARK: Overlay Events
public var rx_didTapOverlay: ControlEvent<GMSOverlay>

// MARK: InfoWindow Events
public var rx_didTapInfoWindowOfMarker: ControlEvent<GMSMarker>
public var rx_didLongPressInfoWindowOfMarker: ControlEvent<GMSMarker>
public var rx_didCloseInfoWindowOfMarker: ControlEvent<GMSMarker>

// MARK: MyLocationButton Event
public var rx_didTapMyLocationButtonForMapView: ControlEvent<Void>

// MARK: Rendering Events
public var rx_mapViewSnapshotReady: ControlEvent<Void>
public var rx_mapViewDidStartTileRendering: ControlEvent<Void>
public var rx_mapViewDidFinishTileRendering: ControlEvent<Void>
```

### `GMSMarker+Rx`
```swift
// MARK: Observer Properties
public var rx_map: AnyObserver<GMSMapView>
public var rx_icon: AnyObserver<UIImage?>
public var rx_position: AnyObserver<CLLocationCoordinate2D>
```

## Reference
* https://github.com/RxSwiftCommunity/RxMKMapView

## License
The MIT License (MIT)

Copyright (c) 2016 Lee Sun-Hyoup

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
