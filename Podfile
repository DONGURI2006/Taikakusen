platform :ios, '15.6'
use_frameworks!

target 'GakuryokuB' do
	pod 'Alamofire', '~> 5.12'
	pod 'ACEDrawingView'
	pod 'SwiftyJSON'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 15.6
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.6'
      end
    end
  end
end
