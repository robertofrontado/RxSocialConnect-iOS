//
//  InstagramApi20.swift
//  RxSocialConnect
//
//  Created by Roberto Frontado on 5/19/16.
//  Copyright © 2016 Roberto Frontado. All rights reserved.
//

import OAuthSwift

open class InstagramApi20: ProviderOAuth20 {
    
    open var consumerKey: String
    open var consumerSecret: String
    open var callbackUrl: URL
    open var scope: String
    
    open var authorizeUrl: String = "https://api.instagram.com/oauth/authorize"
    open var accessTokenUrl: String = ""
    open var responseType: String = "token"
    
    required public init(consumerKey: String, consumerSecret: String, callbackUrl: URL, scope: String) {
        self.consumerKey = consumerKey
        self.consumerSecret = consumerSecret
        self.callbackUrl = callbackUrl
        self.scope = scope
    }
}
