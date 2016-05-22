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
    private func createCredential(expiresOnSeconds: Int) -> OAuthSwiftCredential{
        let credential = OAuthSwiftCredential(consumer_key: "", consumer_secret: "")
        credential.oauth_token_expires_at = NSDate(timeInterval: Double(expiresOnSeconds), sinceDate: NSDate())
        return credential
    }
    
    
}
