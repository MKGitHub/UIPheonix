Pod::Spec.new do |s|

  s.name         = "UIPheonix"
  s.version      = "1.0.0"
  s.summary      = "UIPheonix is simple, it is a framework+concept for build apps where you create reusable UI controls and relate them to different states."

  s.homepage     = "https://github.com/MKGitHub/UIPheonix"

  s.license      = { :type => "Apache License, Version 2.0", :file => "LICENSE.txt" }

  s.author       = { "Mohsan Khan" => "git.mk@xybernic.com" }

  s.osx.deployment_target = "10.11"
  s.ios.deployment_target = "9.0"
  s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/MKGitHub/UIPheonix.git", :tag => "#{s.version}" }

  s.source_files = "UIPheonix/**/*.{swift}"

  s.requires_arc = true

end

