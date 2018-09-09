#
#  Be sure to run `pod spec lint KSOOnboarding.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "KSOOnboarding"
  s.version      = "0.1.0"
  s.summary      = "KSOOnboarding is an iOS framework for on-boarding new users."
  s.description  = <<-DESC
  KSOOnboarding is an iOS framework for on-boarding new users. It can display a background image or video and provides flexible layout options. Each view consists of optional image, headline text, body text, and action text.
                   DESC
                   
  s.homepage     = "https://github.com/Kosoku/KSOOnboarding"
  s.license      = { :type => "BSD", :file => "LICENSE.txt" }
  s.author       = { "William Towe" => "willbur1984@gmail.com" }
  s.source       = { :git => "https://github.com/Kosoku/KSOOnboarding.git", :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.requires_arc = true

  s.source_files  = "KSOOnboarding/**/*.{h,m}"
  s.exclude_files = "KSOOnboarding/KSOOnboarding-Info.h"
  s.private_header_files = "KSOOnboarding/Private/*.h"

  s.resource_bundles = {
    'KSOOnboarding' => ['KSOOnboarding/**/*.{lproj}']
  }

  s.frameworks = "Foundation", "UIKit", "AVFoundation"

  s.dependency "Agamotto"
  s.dependency "Ditko"
  s.dependency "Stanley"
end
