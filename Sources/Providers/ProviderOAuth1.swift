//
//  ProviderOAuth1.swift
//  RxSocialConnect
//
//  Created by Roberto Frontado on 5/19/16.
//  Copyright © 2016 Roberto Frontado. All rights reserved.
//

import OAuthSwift

public protocol ProviderOAuth1 {
    
    var consumerKey: String {get set}
    var consumerSecret: String {get set}
    var callbackUrl: NSURL {get set}
    
    var requestTokenUrl: String {get set}
    var authorizeUrl: String {get set}
    var accessTokenUrl: String {get set}
    
    init(consumerKey: String, consumerSecret: String, callbackUrl: NSURL)
}

public extension ProviderOAuth1 {
 
    internal func getOauth1Swift() -> OAuth1Swift {
        return OAuth1Swift(consumerKey: consumerKey, consumerSecret: consumerSecret, requestTokenUrl: requestTokenUrl, authorizeUrl: authorizeUrl, accessTokenUrl: accessTokenUrl)
    }
    
}