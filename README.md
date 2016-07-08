# RxGoogleMaps
RxGoogleMaps is a [RxSwift](https://github.com/ReactiveX/RxSwift) wrapper for [GoogleMaps](https://developers.google.com/maps/documentation/ios-sdk/start) delegate.

## Usage
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
* Swift 2.2

## Installation
* **CocoaPods**
  * I want to CocoaPods for Installation. But, GoogleMaps is static libarary and CocoaPods doesn't support to static library... <br>Somebody help me!! (GoogleMaps doesn't support Carthage)

* **Manually**
  * To install manually the RxGoogleMaps in an app, just drag the `Sources/*.swift` file into your project.

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
