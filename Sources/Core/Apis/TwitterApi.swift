//
//  TwitterApi.swift
//  RxSocialConnect
//
//  Created by Roberto Frontado on 5/19/16.
//  Copyright © 2016 Roberto Frontado. All rights reserved.
//

import OAuthSwift

open class TwitterApi: ProviderOAuth1 {
    
    open var consumerKey: String
    open var consumerSecret: String
    open var callbackUrl: URL
    
    open var requestTokenUrl: String = "https://api.twitter.com/oauth/request_token"
    open var authorizeUrl: String = "https://api.twitter.com/oauth/authorize"
    open var accessTokenUrl: String = "https://api.twitter.com/oauth/access_token"
    
    required public init(consumerKey: String, consumerSecret: String, callbackUrl: URL) {
        self.consumerKey = consumerKey
        self.consumerSecret = consumerSecret
        self.callbackUrl = callbackUrl
    }

}

