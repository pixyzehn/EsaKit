Pod::Spec.new do |s|
  s.name         = "EsaKit"
  s.version      = "0.1.2"
  s.summary      = "A Swift framework for the esa.io API."
  s.homepage     = "https://github.com/pixyzehn/EsaKit"
  s.license      = "MIT"

  s.author = { "Nagasawa Hiroki" => "civokjots10.pico@gmail.com" }
  s.social_media_url = "http://twitter.com/pixyzehn"

  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = "10.10"

  s.source = { :git => "https://github.com/pixyzehn/EsaKit.git", :tag => "#{s.version}" }
  s.source_files  = "EsaKit/**/*.{swift,h,m}"
  s.requires_arc = true

  s.dependency 'Himotoki', '~> 3.0'
  s.dependency 'ReactiveSwift', '~> 1.0.0-alpha.4'
end
