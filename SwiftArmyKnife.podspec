Pod::Spec.new do |s|
  s.name             = 'SwiftArmyKnife'
  s.version          = '1.0.4'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.summary          = 'Useful extensions for Swift'
  s.homepage         = 'https://github.com/AlexGivens/SwiftArmyKnife'
  s.social_media_url = 'https://twitter.com/AlexGivens_'
  s.author           = { 'Alexander Givens' => 'mail@alexgivens.com' }
  s.source           = { :git => 'https://github.com/AlexGivens/SwiftArmyKnife.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '9.0'

  s.source_files = 'Source/**/*'
  s.frameworks = 'UIKit'
end
