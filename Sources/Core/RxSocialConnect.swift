//
//  RxSocialConnect.swift
//  RxSocialConnect
//
//  Created by Roberto Frontado on 5/18/16.
//  Copyright © 2016 Roberto Frontado. All rights reserved.
//

import RxSwift
import OAuthSwift

open class RxSocialConnect {
    
    fileprivate let ERROR_RETRIEVING_TOKEN = "Error retrieving token"
    private static var oauth1Swift: OAuth1Swift!
    private static var oauth2Swift: OAuth2Swift!
    
    open static func with<T: ProviderOAuth1>(_ viewController: UIViewController, providerOAuth1: T) -> Observable<OAuthSwiftCredential> {
        
        let key = String(describing: T.self).components(separatedBy: ".").last!

        if let response = TokenCache.INSTANCE.get(key, classToken: OAuthSwiftCredential.self) {
            return response
        }
        
        oauth1Swift = providerOAuth1.getOauth1Swift()
        
        oauth1Swift.authorizeURLHandler = CustomURLHandler(viewController: viewController, callbackUrl: providerOAuth1.callbackUrl)
        
        return Observable.create({ subscribe in
            oauth1Swift.authorize(withCallbackURL:
                providerOAuth1.callbackUrl,
                success: { credential, response, parameters in
                    parseParametersIntoCredential(credential, parameters: parameters)
                    TokenCache.INSTANCE.save(key, data: credential)
                    subscribe.onNext(credential)
                    subscribe.onCompleted()
                },
                failure: { error in
                    print(error.localizedDescription)
                    
                    subscribe.onError(error)
                    subscribe.onCompleted()
                }
            )
            return Disposables.create()
        })
    }
    
    open static func with<T: ProviderOAuth20>(_ viewController: UIViewController, providerOAuth20: T) -> Observable<OAuthSwiftCredential> {
        
        let key = String(describing: T.self).components(separatedBy: ".").last!
        
        if let response = TokenCache.INSTANCE.get(key, classToken: OAuthSwiftCredential.self) {
            return response
        }
        
        oauth2Swift = providerOAuth20.getOauth2Swift()
        
        oauth2Swift.authorizeURLHandler = CustomURLHandler(viewController: viewController,  callbackUrl: providerOAuth20.callbackUrl)
        
        let state = generateStateWithLength(20) as String
        
        return Observable.create({ subscribe in
            
            oauth2Swift.authorize(withCallbackURL:
                providerOAuth20.callbackUrl,
                scope: providerOAuth20.scope,
                state: state,
                success: { credential, response, parameters in
                    parseParametersIntoCredential(credential, parameters: parameters)
                    TokenCache.INSTANCE.save(key, data: credential)
                    subscribe.onNext(credential)
                    subscribe.onCompleted()
                },
                failure: { error in
                    print(error.localizedDescription)
                    
                    subscribe.onError(error)
                    subscribe.onCompleted()
                }
            )
            return Disposables.create()
        })
    }
    
    open static func closeConnection<T>(_ classToken: T.Type) -> Observable<Void> {
        return Observable.deferred {
            let key = String(describing: classToken).components(separatedBy: ".").last!
            TokenCache.INSTANCE.evict(key)
            return Observable.empty()
        }
    }
    
    open static func closeConnections() -> Observable<Void> {
        return Observable.deferred {
            TokenCache.INSTANCE.evictAll()
            return Observable.empty()
        }
    }
    
    open static func getOAuthCredential<T>(_ classToken: T.Type) -> Observable<OAuthSwiftCredential> {
        return Observable.deferred {
            
            let key = String(describing: T.self).components(separatedBy: ".").last!
            
            if let credential = TokenCache.INSTANCE.get(key, classToken: OAuthSwiftCredential.self) {
                return credential
            }
            
            return Observable.error(NotActiveTokenFoundException.error)
        }
    }
    
    // MARK: - Private methods
    fileprivate static func generateStateWithLength (_ len : Int) -> NSString {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString : NSMutableString = NSMutableString(capacity: len)
        for _ in 0..<len {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        return randomString
    }
    
    fileprivate static func parseParametersIntoCredential(_ credential: OAuthSwiftCredential, parameters: OAuthSwift.Parameters) {
        if let expiresIn = parameters["expires_in"] as? String,
            let offset = Double(expiresIn)  {
            credential.oauthTokenExpiresAt = Date(timeInterval: offset, since: Date())
        }
    }
}
