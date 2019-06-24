use_frameworks!
inhibit_all_warnings!

platform :ios, '9.0'
workspace 'KinAppreciationModuleOptionsMenu'

abstract_target 'Dependencies' do
  pod 'KinSDK'

  target 'KinAppreciationModuleOptionsMenu' do
    project 'KinAppreciationModuleOptionsMenu/KinAppreciationModuleOptionsMenu'
    target 'KinAppreciationModuleOptionsMenuTests'
  end

  target 'KinAppreciationModuleOptionsMenuSampleApp' do
    project 'KinAppreciationModuleOptionsMenuSampleApp/KinAppreciationModuleOptionsMenuSampleApp' 
  end
end
