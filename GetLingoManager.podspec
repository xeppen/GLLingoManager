Pod::Spec.new do |s|

s.name         = "GetLingoManager"
s.version      = "0.3.2"
s.summary      = "Manager to facilitate connection to GetLingo services."
s.homepage     = "https://github.com/xeppen/GLLingoManager"
s.license      = { :type => "MIT", :file => "LICENSE.md" }
s.author       = "Sebastian Ljungberg"
s.source       = { :git => "https://github.com/xeppen/GLLingoManager.git", :tag => "0.3.2" }
s.source_files  = "Classes", "Classes/*"
s.requires_arc = false

end