#
# Be sure to run `pod lib lint UnitOfWork.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "UnitOfWork"
  s.version          = "0.1.1"
  s.summary          = "This library provides the best bethod for using NSOperations "
  s.description      = <<-DESC
                        This library provides the best bethod for using NSOperations when dealing with Core Data, HTTP, MQTT etc
                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/DanielMandea/UnitOfWork"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Mandea Daniel" => "daniel.mandea@yahoo.com" }
  s.source           = { :git => "https://github.com/DanielMandea/UnitOfWork.git", :tag => "0.1.1"}
  # s.social_media_url = 'https://twitter.com/daniel.mandea'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'UnitOfWork' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
