#
# Be sure to run `pod lib lint DuctTape.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DuctTape'
  s.version          = '0.1.1'
  s.summary          = 'KeyPath dynamicMemberLookup based syntax sugar for Swift.'

  s.homepage         = 'https://github.com/marty-suzuki/DuctTape'
  s.screenshots      = ['https://pbs.twimg.com/media/EF0NJ3QUUAAU3uB?format=png&name=small']
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'marty-suzuki' => 's1180183@gmail.com' }
  s.source           = { :git => 'https://github.com/marty-suzuki/DuctTape.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/marty_suzuki'
  s.swift_version    = '5.1'

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'

  s.source_files = 'Sources/**/*'
  s.frameworks = 'Foundation'
end
