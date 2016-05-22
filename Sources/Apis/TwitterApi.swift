//
//  TwitterApi.swift
//  RxSocialConnect
//
//  Created by Roberto Frontado on 5/19/16.
//  Copyright © 2016 Roberto Frontado. All rights reserved.
//

import OAuthSwift

public class TwitterApi: ProviderOAuth1 {
    
    public var consumerKey: String
    public var consumerSecret: String
    public var callbackUrl: NSURL
    
    public var requestTokenUrl: String = "https://api.twitter.com/oauth/request_token"
    public var authorizeUrl: String = "https://api.twitter.com/oauth/authorize"
    public var accessTokenUrl: String = "https://api.twitter.com/oauth/access_token"
    
    required public init(consumerKey: String, consumerSecret: String, callbackUrl: NSURL) {
        self.consumerKey = consumerKey
        self.consumerSecret = consumerSecret
        self.callbackUrl = callbackUrl
    }

}

