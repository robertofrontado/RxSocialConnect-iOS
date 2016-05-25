//
//  ProviderOAuth20.swift
//  RxSocialConnect
//
//  Created by Roberto Frontado on 5/19/16.
//  Copyright © 2016 Roberto Frontado. All rights reserved.
//

import OAuthSwift

public protocol ProviderOAuth20: ProviderOAuth {
    
    var consumerKey: String {get set}
    var consumerSecret: String {get set}
    var callbackUrl: NSURL {get set}
    var scope: String {get set}
    
    var authorizeUrl: String {get set}
    var accessTokenUrl: String {get set}
    var responseType: String {get set}
    
    init(consumerKey: String, consumerSecret: String, callbackUrl: NSURL, scope: String)
}

public extension ProviderOAuth20 {
    
    internal func getOauth2Swift() -> OAuth2Swift {
        return OAuth2Swift(consumerKey: consumerKey, consumerSecret: consumerSecret, authorizeUrl: authorizeUrl, accessTokenUrl: accessTokenUrl, responseType: responseType)
    }
    
}