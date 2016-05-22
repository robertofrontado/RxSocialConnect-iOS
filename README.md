[![Version](https://img.shields.io/cocoapods/v/RxSocialConnect.svg?style=flat)](http://cocoapods.org/pods/RxSocialConnect)
[![License](https://img.shields.io/cocoapods/l/RxSocialConnect.svg?style=flat)](http://cocoapods.org/pods/RxSocialConnect)
[![Platform](https://img.shields.io/cocoapods/p/RxSocialConnect.svg?style=flat)](http://cocoapods.org/pods/RxSocialConnect)
[![Language](https://img.shields.io/badge/language-swift-orange.svg?style=flat)](https://developer.apple.com/swift)

OAuth RxSwift extension for iOS.

# RxSocialConnect-iOS

RxSocialConnect simplifies the process of retrieving authorizations tokens from multiple social networks to a minimalist observable call, from any ViewController

```swift
let facebookApi20: FacebookApi20 = // ...
        
RxSocialConnect.with(self, providerOAuth20: facebookApi20)
            .subscribeNext { credential in self.showAlert(credential.oauth_token) }
```

# Features

 - Webview implementation to handle the sequent steps of oauth process.
 - Storage tokens locally.
 - Automatic refreshing tokens taking care of expiration date.
 - Mayor social network supported; including Facebook, Twitter, GooglePlus, LinkedIn, Instagram and so on.

# Setup

Add RxSocialConnect-iOS to your podfile
```
pod 'RxSocialConnect'
```

# Usage

## Retrieving tokens using OAuth1

On social networks which use OAuth1 protocol to authenticate users (such us Twitter), you need to build an instance of an object which inherits from ProviderOAuth1 and pass it to RxSocialConnect.

```swift
let twitterApi = TwitterApi(
            consumerKey: consumerKey,
            consumerSecret: consumerSecret,
            callbackUrl: callbackURL
        )
        
RxSocialConnect.with(self, providerOAuth1: twitterApi)
            .subscribeNext { credential in self.showAlert(credential.oauth_token) }
```


## Retrieving tokens using OAuth2

On social networks which use OAuth2 protocol to authenticate users (such us Facebook, Google+ or LinkedIn), you need to build an instance of an object which inherits from ProviderOAuth1 and pass it to RxSocialConnect.

```swift
let facebookApi20 = FacebookApi20(
            consumerKey: consumerKey,
            consumerSecret: consumerSecret,
            callbackUrl: callbackURL,
            scope: "public_profile"
        )
        
RxSocialConnect.with(self, providerOAuth20: facebookApi20)
            .subscribeNext { credential in self.showAlert(credential.oauth_token) }
```

# Token lifetime

After retrieving the token, RxSocialConnect will save it on disk to return it on future calls without doing again the oauth process. This token only will be evicted from cache if its expiration time has been fulfilled.

But, if you need to close an specific connection (or delete the token from the disk for that matters), you can call `RxSocialConnect.closeConnection(baseApiClass)` at any time to evict the cached token -where baseApiClass is the provider class used on the oauth process

```swift
// Facebook
RxSocialConnect.closeConnection(FacebookApi20.self)
	.subscribeNext { self.showAlert("Facebook disconnected") }
```

```swift
// Twitter
RxSocialConnect.closeConnection(TwitterApi.self)
	.subscribeNext { self.showAlert("Twitter disconnected") }
```
You can also close all the connections at once, calling `RxSocialConnect.closeConnections()`

```swift
RxSocialConnect.closeConnections()
	.subscribeNext { self.showAlert("All disconnected") }
```

# Credits

 - OAuth core authentication: [OAuthSwift](https://github.com/OAuthSwift/OAuthSwift)

# Author

**Roberto Frontado**

 - https://linkedin.com/in/robertofrontado
 - https://github.com/robertofrontado
 - https://twitter.com/robertofrontado

# Another author's libraris using RxSwift:

 - [BaseApp-iOS](https://github.com/FuckBoilerplate/base_app_ios): Base skeleton structure to start every new iOS project
 - [OkDataSources](https://github.com/FuckBoilerplate/OkDataSources): Wrappers for iOS TableView and CollectionView DataSources to simplify its api at a minimum. Also it has a cool PagerView and SlidingTabs!
 - [RxGcm-iOS](https://github.com/FuckBoilerplate/RxGcm-iOS): RxSwift extension for iOS Google Cloud Messaging (aka gcm).
