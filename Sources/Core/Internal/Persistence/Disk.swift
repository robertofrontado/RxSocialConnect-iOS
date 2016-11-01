//
//  Disk.swift
//  RxSocialConnect
//
//  Created by Roberto Frontado on 5/23/16.
//  Copyright © 2016 Roberto Frontado. All rights reserved.
//

import OAuthSwift
import RxSwift

open class Disk {
    
    fileprivate let cacheDirectory: String
    fileprivate let NAME_DIR = "RxSocialConnect"
    
    public init() {
        let fileManager = FileManager.default
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory: AnyObject = paths[0] as AnyObject
        let dirPath: String = documentsDirectory.appendingPathComponent(NAME_DIR)
        
        if !fileManager.fileExists(atPath: dirPath) {
            do {
                try fileManager.createDirectory(atPath: dirPath, withIntermediateDirectories: false, attributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        cacheDirectory = dirPath + "/"
        
    }
    
    open func save<T: OAuthSwiftCredential>(_ key: String, data: T) -> Bool {
        return NSKeyedArchiver.archiveRootObject(data, toFile: cacheDirectory+key)
    }
    
    open func get<T: OAuthSwiftCredential>(_ keyToken: String, classToken: T.Type) -> Observable<T>? {
        if let response = retrieve(keyToken, clazz: classToken) {
            if !response.isTokenExpired() {
                return Observable.just(response)
            }
        }
        return nil
    }
    
    fileprivate func retrieve<T: OAuthSwiftCredential>(_ key: String, clazz: T.Type) -> T? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: cacheDirectory+key) as? T
    }
    
    open func evict(_ key: String) {
        do {
            try FileManager.default.removeItem(atPath: cacheDirectory+key)
            print("Deleted data for key " + key)
        } catch {
            print("Failed to delete data for key " + key)
        }
    }
    
    open func evictAll() {
        do {
            try FileManager.default.removeItem(atPath: cacheDirectory)
            print("Deleted all stored data")
        } catch {
            print("Failed to delete all stored data")
        }
    }
}
