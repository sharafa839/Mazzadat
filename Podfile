# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'Mazadaat' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # pod 'ExpandableCell'
  
  pod 'IQKeyboardManagerSwift'
  pod 'SDWebImage'
  pod 'SwiftyJSON'
  pod 'Toast-Swift'
  pod 'CollapsibleTableSectionViewController', '~> 2.0.1'
  pod 'IAPurchaseManager'
  pod 'SwiftyStoreKit'
  pod 'Spring'
  pod 'Swime'
  pod "RappleProgressHUD"
  pod "ImageSlideshow/SDWebImage"
  pod 'OTPFieldView'
  pod 'GoogleMaps'
  pod 'GooglePlaces'
  pod 'GooglePlacePicker'
  pod 'SideMenu', '~> 5.0.1'
  pod 'SwiftyGif'
  
  pod 'SwiftGifOrigin'
  pod 'SwiftDate', '~> 5.0'
  
  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'Firebase/Messaging'
  pod 'FirebaseFirestoreSwift'
  pod 'OTPFieldView'
  pod 'RxSwift', '~> 5.1.1'
  pod 'RxCocoa', '~> 5.1.1'
  pod 'ReachabilitySwift'
  pod 'Kingfisher', '~> 5.13.4'
  pod 'SwiftKeychainWrapper', '~> 4.0.1'
  pod "ImageSlideshow/Kingfisher"
  pod 'Moya', '~> 15.0'
  pod 'NotificationBannerSwift', '~> 3.0.0'
  pod 'NVActivityIndicatorView'
  pod 'Firebase/Database'

  # Pods for Mazadaat
  post_install do |installer|
    installer.generated_projects.each do |project|
      project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        end
      end
    end
  end
  
end
