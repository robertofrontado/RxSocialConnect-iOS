//
//  TokenCache.swift
//  RxSocialConnect
//
//  Created by Roberto Frontado on 5/23/16.
//  Copyright © 2016 Roberto Frontado. All rights reserved.
//

import RxSwift
import OAuthSwift

class TokenCache {

    fileprivate let disk: Disk
    fileprivate var memory: [String: AnyObject]
    
    static let INSTANCE = TokenCache()
    
    fileprivate init() {
        disk = Disk()
        memory = [String: AnyObject]()
    }
    
    func save<T: OAuthSwiftCredential>(_ key: String, data: T) {
        memory.updateValue(Observable.just(data), forKey: key)
        disk.save(key, data: data)
    }
    
    func get<T: OAuthSwiftCredential>(_ keyToken: String, classToken: T.Type) -> Observable<T>? {
        var token = memory[keyToken]
        if token == nil {
            token = disk.get(keyToken, classToken: classToken)
            if let token = token {
                memory.updateValue(token, forKey: keyToken)
            }
        }
        return token as? Observable<T>
    }
    
    func evict(_ key: String) {
        memory.removeValue(forKey: key)
        disk.evict(key)
    }
    
    func evictAll() {
        memory.removeAll()
        disk.evictAll()
    }
}
