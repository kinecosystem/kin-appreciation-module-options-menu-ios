Pod::Spec.new do |s|
  s.name              = 'KinAppreciationModuleOptionsMenu'
  s.version           = '0.0.1'
  s.license           = { :type => 'Kin Ecosystem SDK License', :file => 'LICENSE.md' }
  s.author            = { 'Kin Foundation' => 'info@kin.org' }
  s.summary           = 'Appreciation module pod for the Kin SDK.'
  s.homepage          = 'https://github.com/kinecosystem/kin-appreciation-module-options-menu-ios'
  # s.documentation_url = 'https://kinecosystem.github.io/kin-website-docs/docs/'
  s.social_media_url  = 'https://twitter.com/kin_foundation'
  
  s.platform      = :ios, '9.0'
  s.swift_version = '5.0'

  s.source = { 
    :git => 'https://github.com/kinecosystem/kin-appreciation-module-options-menu-ios.git', 
    :tag => s.version.to_s
  }
  s.source_files = 'KinAppreciationModuleOptionsMenu/KinAppreciationModuleOptionsMenu/**/*.swift'

  s.dependency 'KinSDK', '~> 1.0.0'

  # ss.test_spec 'Tests' do |sts|
  #   sts.requires_app_host = true
  #   sts.source_files      = 'KinSDK/KinSDKTests/Core/*.swift'
  # end

  # ss.app_spec 'SampleApp' do |sas|
  #   root = 'SampleApps/KinSDKSampleApp/KinSDKSampleApp'

  #   sas.pod_target_xcconfig = { 'INFOPLIST_FILE' => '${PODS_TARGET_SRCROOT}/'+root+'/Info.plist' }
  #   sas.source_files        = root+'/**/*.{strings,swift}'
  #   sas.resources           = root+'/**/*.{storyboard,xcassets}'
  # end
end
