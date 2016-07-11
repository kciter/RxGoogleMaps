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
* Swift 2.2+

## Installation
* **CocoaPods**
  * GoogleMaps is static libarary and CocoaPods doesn't support to static library...<br>So normally it can't be used. But, if you want to use CocoaPods, see below.
  ```ruby
  # Podfile Sample
  target 'RxGoogleMaps-Sample' do
    use_frameworks!
    pod 'RxGoogleMaps', :git => 'https://github.com/kciter/RxGoogleMaps', :tag => "0.1"
  end

  Pod::Installer.class_eval { def verify_no_static_framework_transitive_dependencies; end }

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      if target.name.eql?("RxGoogleMaps")
        target.build_configurations.each do |config|
          config.build_settings['FRAMEWORK_SEARCH_PATHS'] = ["$(inherited)", "$(PODS_ROOT)/GoogleMaps/Frameworks"]
        end
      end
  
      if target.name.eql?("Pods-RxGoogleMaps-Sample")
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
