#
#  Be sure to run `pod spec lint StringScore.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "StringScore"
  s.version      = "0.0.1"
  s.summary      = "Cloned from https://github.com/thetron/StringScore.git"
  s.description  = <<-DESC
StringScore is an Objective-C library which provides super fast fuzzy string matching/scoring. Based on the JavaScript library of the same name.
                   DESC
  s.homepage     = "https://github.com/zalexej/StringScore"
  s.license      = { :type => "MIT", :file => "README.md" }
  s.author    = "zalexej"
  s.platform     = :ios
  s.source       = { :git => "https://github.com/zalexej/StringScore.git", :tag => "0.0.1" }
  s.source_files  = "NSString+Score.{h,m}"
  s.requires_arc = true
end
