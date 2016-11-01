//
//  RxSocialConnectTests.swift
//  RxSocialConnectTests
//
//  Created by Roberto Frontado on 5/18/16.
//  Copyright © 2016 Roberto Frontado. All rights reserved.
//

import XCTest
import OAuthSwift
import Nimble
@testable import RxSocialConnect

class RxSocialConnectTests: XCTestCase {
    
    // MARK: - Tests
    func testWhenTokenExpiresThenExpire() {
        let expiresOnSeconds: Int = 3
        let credential = createCredential(expiresOnSeconds)
        
        sleep(4)
        
        expect(credential.isTokenExpired()).to(beTrue())
    }
    
    func testWhenTokenNotExpireThenNotExpire() {
        let expiresOnSeconds: Int = 3
        let credential = createCredential(expiresOnSeconds)
        
        sleep(1)
        
        expect(credential.isTokenExpired()).to(beFalse())
    }
    
    // MARK: - Private methods
    fileprivate func createCredential(_ expiresOnSeconds: Int) -> OAuthSwiftCredential{
        let credential = OAuthSwiftCredential(consumer_key: "", consumer_secret: "")
        credential.oauth_token_expires_at = Date(timeInterval: Double(expiresOnSeconds), since: Date())
        return credential
    }
    
    
}
