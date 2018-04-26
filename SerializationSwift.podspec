#
# Be sure to run `pod lib lint SerializationSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SerializationSwift'
  s.version          = '0.1.0'
  s.summary          = 'The SerializationSwift library uses the Codable native mechanism used to decode and encode bytes.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'The SerializationSwift library uses the native Decodable mechanism used to decode and encode bytes, when we want to assign custom json keys and identify decoding error for each json key.'

  s.homepage         = 'https://github.com/roneloza/SerializationSwift.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rone.loza@gmail.com' => 'rone.loza@gmail.com' }
  s.source           = { :git => 'https://github.com/roneloza/SerializationSwift.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.3'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.1' }
  
  #s.default_subspecs= [
  #"Core"
  #"Static"
  #]
  
  #s.subspec "SerializationSwift" do |ss|
  #    ss.vendored_frameworks = [
  #    "SerializationSwift/Frameworks/SerializationSwift-Release-iphoneuniversal/SerializationSwift.framework"
  #    ]
  #end
  
  s.vendored_frameworks = [
  "SerializationSwift/Frameworks/SerializationSwift-Release-iphoneuniversal/SerializationSwift.framework"
  ]
  
  # s.resource_bundles = {
  #   'SerializationSwift' => ['SerializationSwift/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  #s.frameworks = 'SerializationSwift'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  #s.ios.vendored_frameworks = 'SerializationSwift/Frameworks/SerializationSwift-Release-iphoneuniversal/SerializationSwift.framework'
  #s.source_files = 'Framework/SerializationSwift/**/'
  #s.public_header_files = 'SerializationSwift/Frameworks/SerializationSwift-Release-iphoneuniversal/SerializationSwift.framework/Headers/.h'
  #s.frameworks = 'SerializationSwift'
  
  #s.public_header_files = "SerializationSwift/Frameworks/SerializationSwift-Release-iphoneuniversal/SerializationSwift.framework/Headers/*.h"
  #s.module_map = "SerializationSwift/Frameworks/SerializationSwift-Release-iphoneuniversal/SerializationSwift.framework/Modules/module.modulemap"
  #s.preserve_paths = "SerializationSwift/Frameworks/SerializationSwift-Release-iphoneuniversal/SerializationSwift.framework/*"
  #s.requires_arc = true
  #s.module_name = 'SerializationSwift'
  #s.source_files = 'SerializationSwift/Frameworks/SerializationSwift-Release-iphoneuniversal/SerializationSwift.framework/Headers/*.swift'
end
