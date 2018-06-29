Pod::Spec.new do |s|
  s.name = "Uneri"
  s.version = "1.0.1"
  s.summary = "Uneri (うねり) is a wave animation view library 🌊"
  s.homepage = "https://github.com/jimmythai/Uneri"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "Atsuthi Yamamoto" => "ayamam1127@gmail.com" }
  s.source = { :git => "https://github.com/jimmythai/Uneri.git", :tag => s.version }

  s.ios.deployment_target = '8.0'

  s.source_files = "Uneri/*.swift"
end
