Pod::Spec.new do |s|
  s.name         = 'RxSocialConnectExample'
  s.version      = '<#Project Version#>'
  s.license      = '<#License#>'
  s.homepage     = '<#Homepage URL#>'
  s.authors      = '<#Author Name#>': '<#Author Email#>'
  s.summary      = '<#Summary (Up to 140 characters#>'

  s.platform     =  :ios, '<#iOS Platform#>'
  s.source       =  git: '<#Github Repo URL#>', :tag => s.version
  s.source_files = '<#Resources#>'
  s.frameworks   =  '<#Required Frameworks#>'
  s.requires_arc = true
  
# Pod Dependencies
  s.dependencies =	pod 'OAuthSwift', '~> 0.5.0'
  s.dependencies =	pod 'RxSwift', '~> 2.5.0'
  s.dependencies =	pod 'RxBlocking', '~> 2.5.0'
  s.dependencies =	pod 'Alamofire', '~> 3.0'
  s.dependencies =	pod 'Moya', '~> 6.5.0'
  s.dependencies =	pod 'Moya/RxSwift', '~> 6.5.0'

end