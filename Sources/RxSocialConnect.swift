//
//  RxSocialConnect.swift
//  RxSocialConnect
//
//  Created by Roberto Frontado on 5/18/16.
//  Copyright © 2016 Roberto Frontado. All rights reserved.
//

import RxSwift
import OAuthSwift

public class RxSocialConnect {
    
    private let ERROR_RETRIEVING_TOKEN = "Error retrieving token"
    
    public static func with<T: ProviderOAuth1>(viewController: UIViewController, providerOAuth1: T) -> Observable<OAuthSwiftCredential> {
        
        let tokenPersistence = TokenPersistence()
        let key = String(T)

        if let response = tokenPersistence.get(key, classToken: OAuthSwiftCredential.self) {
            return response
        }
        
        let oauth1Swift = providerOAuth1.getOauth1Swift()
        
        oauth1Swift.authorize_url_handler = CustomURLHandler(viewController: viewController, callbackUrl: providerOAuth1.callbackUrl)
        
        return Observable.create({ subscribe in
            
            oauth1Swift.authorizeWithCallbackURL(
                providerOAuth1.callbackUrl,
                success: { credential, response, parameters in
                    parseParametersIntoCredential(credential, parameters: parameters)
                    tokenPersistence.save(key, data: credential)
                    subscribe.onNext(credential)
                    subscribe.onCompleted()
                },
                failure: { error in
                    print(error.localizedDescription)
                    
                    subscribe.onError(error)
                    subscribe.onCompleted()
                }
            )
            return NopDisposable.instance
        })
    }
    
    public static func with<T: ProviderOAuth20>(viewController: UIViewController, providerOAuth20: T) -> Observable<OAuthSwiftCredential> {
        
        let tokenPersistence = TokenPersistence()
        let key = String(T)
        
        if let response = tokenPersistence.get(key, classToken: OAuthSwiftCredential.self) {
            return response
        }
        
        let oauth2Swift = providerOAuth20.getOauth2Swift()
        
        oauth2Swift.authorize_url_handler = CustomURLHandler(viewController: viewController,  callbackUrl: providerOAuth20.callbackUrl)
        
        let state = generateStateWithLength(20) as String
        
        return Observable.create({ subscribe in
            
            oauth2Swift.authorizeWithCallbackURL(
                providerOAuth20.callbackUrl,
                scope: providerOAuth20.scope,
                state: state,
                success: { credential, response, parameters in
                    parseParametersIntoCredential(credential, parameters: parameters)
                    tokenPersistence.save(key, data: credential)
                    subscribe.onNext(credential)
                    subscribe.onCompleted()
                },
                failure: { error in
                    print(error.localizedDescription)
                    
                    subscribe.onError(error)
                    subscribe.onCompleted()
                }
            )
            return NopDisposable.instance
        })
    }
    
    public static func closeConnection<T>(classToken: T.Type) -> Observable<Void> {
        return Observable.deferred {
            let tokenPersistence = TokenPersistence()
            tokenPersistence.evict(String(classToken))
            return Observable.just()
        }
    }
    
    public static func closeConnections() -> Observable<Void> {
        return Observable.deferred {
            let tokenPersistence = TokenPersistence()
            tokenPersistence.evictAll()
            return Observable.just()
        }
    }
    
    // MARK: - Private methods
    private static func generateStateWithLength (len : Int) -> NSString {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString : NSMutableString = NSMutableString(capacity: len)
        for _ in 0..<len {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        return randomString
    }
    
    private static func parseParametersIntoCredential(credential: OAuthSwiftCredential, parameters: [String: String]) {
        if let expiresIn:String = parameters["expires_in"], offset = Double(expiresIn)  {
            credential.oauth_token_expires_at = NSDate(timeInterval: offset, sinceDate: NSDate())
        }
    }
}
