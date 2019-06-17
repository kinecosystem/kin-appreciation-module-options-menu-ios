use_frameworks!
inhibit_all_warnings!
install!  'cocoapods', 
          :generate_multiple_pod_projects => true,  # Cocoapods 1.7.0
          :incremental_installation => true         # Cocoapods 1.7.0

platform :ios, '9.0'
workspace 'KinAppreciationModuleOptionsMenu'

abstract_target 'Dependencies' do
  pod 'KinSDK'

  target 'KinAppreciationModuleOptionsMenu' do
    project 'KinAppreciationModuleOptionsMenu/KinAppreciationModuleOptionsMenu.xcodeproj'
  end

  # target 'KinSDKTests' do
  #   project 'KinSDK/KinSDK.xcodeproj'
  # end
  
  target 'KinAppreciationModuleOptionsMenuSampleApp' do
    project 'KinAppreciationModuleOptionsMenuSampleApp/KinAppreciationModuleOptionsMenuSampleApp.xcodeproj'
  end
end