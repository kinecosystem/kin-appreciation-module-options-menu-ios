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
  s.source_files = 'KinAppreciationModuleOptionsMenu/KinAppreciationModuleOptionsMenu/**/*.{strings,swift}'
  s.resources    = 'KinAppreciationModuleOptionsMenu/KinAppreciationModuleOptionsMenu/**/*.{xcassets}'
  s.resource_bundles = {
    'KinAppreciationModuleOptionsMenu' => ['KinAppreciationModuleOptionsMenu/KinAppreciationModuleOptionsMenu/**/*.{ttf,otf}']
  }

  s.dependency 'KinSDK', '~> 1.0.0'

  s.test_spec 'Tests' do |ts|
    ts.source_files = 'KinAppreciationModuleOptionsMenu/KinAppreciationModuleOptionsMenuTests/*.swift'
  end

  s.app_spec 'SampleApp' do |as|
    root = 'KinAppreciationModuleOptionsMenuSampleApp/KinAppreciationModuleOptionsMenuSampleApp'

    as.source_files = root+'/**/*.swift'
    as.resources    = root+'/**/*.{storyboard,xcassets}'
  end
end
