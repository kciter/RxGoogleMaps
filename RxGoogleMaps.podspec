Pod::Spec.new do |s|
  s.name         = "RxGoogleMaps"
  s.version      = "0.1"
  s.summary      = "RxGoogleMaps is a RxSwift wrapper for GoogleMaps `delegate`."
  s.homepage     = "https://github.com/kciter/RxGoogleMaps"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "kciter" => "kciter@naver.com" }
  s.source       = { :git => "https://github.com/kciter/RxGoogleMaps.git", :tag => "#{s.version}" }
  s.platform     = :ios, '8.0'
  s.source_files = 'Sources/*.{swift}'
  s.frameworks   = [
	'UIKit', 
	'Foundation',
    "Accelerate",
    "AVFoundation",
    "CoreBluetooth",
    "CoreData",
    "CoreLocation",
    "CoreText",
    "GLKit",
    "ImageIO",
    "OpenGLES",
    "QuartzCore",
    "Security",
    "SystemConfiguration",
    "CoreGraphics",
	"GoogleMaps"
  ]
  s.libraries    = 'c++', 'z', 'icucore'
  s.dependency 'RxSwift', '~> 2.5'
  s.dependency 'RxCocoa', '~> 2.5'
  s.dependency 'GoogleMaps', '~> 1.13'
  s.requires_arc = true
end
