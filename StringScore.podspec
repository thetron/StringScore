Pod::Spec.new do |s|
  s.name         = "StringScore"
  s.version      = "0.0.2"
  s.summary      = "StringScore is an Objective-C library which provides super fast fuzzy string matching/scoring. Based on the JavaScript library of the same name."
  s.homepage     = "https://github.com/yichizhang/" + s.name
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Nicholas Bruning" => "nicholas@bruning.com.au" }
  s.source       = {
    :git => "https://github.com/yichizhang/" + s.name + ".git",
    :tag => s.version.to_s
  }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Source/*.{h,m}'

  s.framework  = 'Foundation', 'UIKit'

end