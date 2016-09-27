
Pod::Spec.new do |s|
  s.name         = "HHSlideView"
  s.version      = "1.0.0"
  s.summary      = "An custom segment control view with flat style."
  s.description  = <<-DESC
                   HHSlideView is a falt view with segment control function. It's easy to be integrated into your project.
                   DESC
  s.homepage     = "https://github.com/Herbert77/HHSlideView"
  s.license      = "MIT"
  s.author       = { "Herbert Hu" => "herbert7789@hotmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Herbert77/HHSlideView.git", :tag => "0.0.1" }
  s.source_files = "Example/HHSlideViewExample/*.{h,m}"
  s.framework    = "UIKit"
  s.requires_arc = true

end
