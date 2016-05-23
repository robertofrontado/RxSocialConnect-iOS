Pod::Spec.new do |s|
  s.name         = "RxSocialConnect"
  s.version      = "0.0.2"
  s.summary      = "OAuth RxSwift extension for iOS."

  s.homepage     = "https://github.com/FuckBoilerplate/RxSocialConnect-iOS"
  s.license = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Roberto Frontado" => "robertofrontado@gmail.com" }
  s.source           = { :git => "https://github.com/FuckBoilerplate/RxSocialConnect-iOS.git", :tag => s.version.to_s }
  s.social_media_url   = "https://github.com/FuckBoilerplate"

  s.ios.deployment_target = '8.0'
  s.requires_arc = true

  s.source_files = 'Sources/**/*'

  s.dependency "RxSwift", "~> 2.0.0"
  s.dependency "OAuthSwift", "~> 0.5.0"
  
end
