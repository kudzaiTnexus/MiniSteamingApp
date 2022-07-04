# Uncomment the next line to define a global platform for your project
 platform :ios, '13.0'

target 'MiniSteamingApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  #use_frameworks!
  inhibit_all_warnings!
    pod 'Nuke', '10.7.1'
    pod "Texture", '3.1.0'
    pod 'RxSwift', '6.5.0'
    pod 'RxCocoa', '6.5.0'

  target 'MiniSteamingAppTests' do
    inherit! :search_paths
    pod 'Cuckoo', '1.8.0'
    pod 'RxBlocking', '6.5.0'
    pod 'RxTest', '6.5.0'
  end

  target 'MiniSteamingAppUITests' do
    inherit! :search_paths
    pod 'Swifter', '1.5.0'
  end

  post_install do |installer_representation|
      installer_representation.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.2'
              config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = '$(inherited)'
          end
      end
  end
    
    ENV["COCOAPODS_DISABLE_STATS"] = "true"
end
