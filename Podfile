# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'CanGatewayApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Pokedex
pod 'RxSwift’#,    	'~> 3.0'
pod 'RxCocoa’#,    	'~> 3.0'
pod 'RxDataSources’,   ’~> 1.0'
pod 'RealmSwift'

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
  end



end