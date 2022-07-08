platform :ios, '14.0'


def import_shared_pods
 pod 'NukeUI'
end

target 'MiniSteamingApp' do
 inhibit_all_warnings!
 import_shared_pods

 target 'MiniSteamingAppTests' do
   inherit! :search_paths
 end

 target 'MiniSteamingAppUITests' do
   inherit! :search_paths
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
