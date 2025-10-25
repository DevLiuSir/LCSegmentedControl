Pod::Spec.new do |spec|

  spec.name           = "LCSegmentedControl"

  spec.version        = "1.0.0"
  
  spec.summary        = "LCSegmentedControl is a lightweight framework for customizing the background color of NSSegmentedControl selected items"

  spec.description    = <<-DESC
LCSegmentedControl is a lightweight Cocoa framework that supports customizing the background color of the selected item of NSSegmentedControl!
                      DESC

  spec.homepage       = "https://github.com/DevLiuSir/LCSegmentedControl"
  
  spec.license        = { :type => "MIT", :file => "LICENSE" }
  
  spec.author         = { "Marvin" => "93428739@qq.com" }

  spec.swift_versions = ['5.0']
  
  spec.platform       = :osx

  spec.osx.deployment_target = "10.14"

  spec.source       = { :git => "https://github.com/DevLiuSir/LCSegmentedControl.git", :tag => "#{spec.version}" }

  spec.source_files   = "Sources/LCSegmentedControl/**/*.{h,m,swift}"

end
