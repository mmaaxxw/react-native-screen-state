
Pod::Spec.new do |s|
  s.name         = "RNScreenState"
  s.version      = "0.0.1"
  s.summary      = "RNScreenState"
  s.description  = <<-DESC
                  RNScreenState
                   DESC
  s.homepage     = ""
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "author@domain.cn" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/author/RNScreenState.git", :tag => "master" }
  s.source_files  = "RNScreenState/**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  #s.dependency "others"

end

