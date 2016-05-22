//
//  TokenPersistence.swift
//  RxSocialConnect
//
//  Created by Roberto Frontado on 5/18/16.
//  Copyright © 2016 Roberto Frontado. All rights reserved.
//

import Foundation
import OAuthSwift
import RxSwift

public class TokenPersistence {
    
    private let cacheDirectory: String
    private let NAME_DIR = "RxSocialConnect"
    
    public init() {
        let fileManager = NSFileManager.defaultManager()
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory: AnyObject = paths[0]
        let dirPath = documentsDirectory.stringByAppendingPathComponent(NAME_DIR)
        
        if !fileManager.fileExistsAtPath(dirPath) {
            do {
                try fileManager.createDirectoryAtPath(dirPath, withIntermediateDirectories: false, attributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        cacheDirectory = dirPath + "/"
        
    }
    
    public func save<T: OAuthSwiftCredential>(key: String, data: T) -> Bool {
        return NSKeyedArchiver.archiveRootObject(data, toFile: cacheDirectory+key)
    }
    
    public func get<T: OAuthSwiftCredential>(keyToken: String, classToken: T.Type) -> Observable<T>? {
        if let response = retrieve(keyToken, clazz: classToken) {
            if !response.isTokenExpired() {
                return Observable.just(response)
            }
        }
        return nil
    }
    
    private func retrieve<T: OAuthSwiftCredential>(key: String, clazz: T.Type) -> T? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(cacheDirectory+key) as? T
    }
    
    public func evict(key: String) {
        do {
            try NSFileManager.defaultManager().removeItemAtPath(cacheDirectory+key)
            print("Deleted data for key " + key)
        } catch {
            print("Failed to delete data for key " + key)
        }
    }
    
    public func evictAll() {
        do {
            try NSFileManager.defaultManager().removeItemAtPath(cacheDirectory)
            print("Deleted all stored data")
        } catch {
            print("Failed to delete all stored data")
        }
    }
}
