#
# Be sure to run `pod lib lint SwiftJsonThemeManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftJsonThemeManager'
  s.version          = '0.1'
  s.summary          = 'SwiftJsonThemeManager it is a helper library for you apply theme like colours, font, and more, in a very easy way.'

  s.description      = <<-DESC
Easy Swift Theme Manager based on JSON file, easy and clean to understand and apply theme to your project, have a project that customize, color, font, size, you should use theme manager in order to have one central point and done, need to refresh the view without close the view? This is your tool.
                       DESC

  s.homepage         = 'https://github.com/felipeflorencio/SwiftJsonThemeManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'GNU', :file => 'LICENSE' }
  s.author           = { 'Felipe F Garcia' => 'felipeflorencio@me.com' }
  s.source           = { :git => 'https://github.com/felipeflorencio/SwiftJsonThemeManager.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/dr_nerd'

  s.ios.deployment_target = '10.0'
  s.swift_version = '4.2'

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.2' }

  s.source_files = 'SwiftJsonThemeManager/Classes/**/*'

end
