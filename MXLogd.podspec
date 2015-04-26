#
# Be sure to run `pod lib lint MXLogd.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "MXLogd"
  s.version          = "0.1.0"
  s.summary          = "A short description of MXLogd."
  s.description      = <<-DESC
                       An optional longer description of MXLogd

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/imixun/MXLogd"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "wuxingyu1983" => "leowu@imixun.com" }
  s.source           = { :git => "https://github.com/imixun/MXLogd.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'MXLogd/Classes/**/*'
  s.resource_bundles = {
    'MXLogd' => ['MXLogd/Assets/*.png']
  }

  s.public_header_files = 'MXLogd/Classes/MXLogd.h'
  s.frameworks = 'CrashReporter'
  s.dependency 'AFNetworking', '2.5.3'
  s.dependency 'PLCrashReporter', '1.2.0'
  s.dependency 'OpenUDID', '1.0.0' 
end
