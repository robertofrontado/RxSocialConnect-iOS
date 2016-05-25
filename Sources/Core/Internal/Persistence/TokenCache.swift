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

    private let disk: Disk
    private var memory: [String: AnyObject]
    
    static let INSTANCE = TokenCache()
    
    private init() {
        disk = Disk()
        memory = [String: AnyObject]()
    }
    
    func save<T: OAuthSwiftCredential>(key: String, data: T) {
        memory.updateValue(data, forKey: key)
        disk.save(key, data: data)
    }
    
    func get<T: OAuthSwiftCredential>(keyToken: String, classToken: T.Type) -> Observable<T>? {
        var token = memory[keyToken]
        if token == nil {
            token = disk.get(keyToken, classToken: classToken)
            if let token = token {
                memory.updateValue(token, forKey: keyToken)
            }
        }
        return token as? Observable<T>
    }
    
    func evict(key: String) {
        memory.removeValueForKey(key)
        disk.evict(key)
    }
    
    func evictAll() {
        memory.removeAll()
        disk.evictAll()
    }
}
