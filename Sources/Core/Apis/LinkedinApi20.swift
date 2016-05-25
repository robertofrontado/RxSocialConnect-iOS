//
//  LinkedinApi20.swift
//  RxSocialConnect
//
//  Created by Roberto Frontado on 5/19/16.
//  Copyright © 2016 Roberto Frontado. All rights reserved.
//

import OAuthSwift

public class LinkedinApi20: ProviderOAuth20 {
    
    public var consumerKey: String
    public var consumerSecret: String
    public var callbackUrl: NSURL
    public var scope: String
    
    public var authorizeUrl: String = "https://www.linkedin.com/uas/oauth2/authorization"
    public var accessTokenUrl: String = "https://www.linkedin.com/uas/oauth2/accessToken"
    public var responseType: String = "code"
    
    required public init(consumerKey: String, consumerSecret: String, callbackUrl: NSURL, scope: String) {
        self.consumerKey = consumerKey
        self.consumerSecret = consumerSecret
        self.callbackUrl = callbackUrl
        self.scope = scope
    }
    
}


