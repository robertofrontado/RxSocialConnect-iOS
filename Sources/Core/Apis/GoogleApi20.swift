//
//  GoogleApi20.swift
//  RxSocialConnect
//
//  Created by Roberto Frontado on 5/19/16.
//  Copyright © 2016 Roberto Frontado. All rights reserved.
//

import OAuthSwift

public class GoogleApi20: ProviderOAuth20 {
    
    public var consumerKey: String
    public var consumerSecret: String
    public var callbackUrl: NSURL
    public var scope: String
    
    public var authorizeUrl: String = "https://accounts.google.com/o/oauth2/auth"
    public var accessTokenUrl: String = ""
    public var responseType: String = "token"
    
    required public init(consumerKey: String, consumerSecret: String, callbackUrl: NSURL, scope: String) {
        self.consumerKey = consumerKey
        self.consumerSecret = consumerSecret
        self.callbackUrl = callbackUrl
        self.scope = scope
    }
}
