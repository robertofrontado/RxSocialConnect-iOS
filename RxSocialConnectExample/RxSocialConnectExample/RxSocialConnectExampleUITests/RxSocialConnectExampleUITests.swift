//
//  RxSocialConnectExampleUITests.swift
//  RxSocialConnectExampleUITests
//
//  Created by Roberto Frontado on 5/18/16.
//  Copyright © 2016 Roberto Frontado. All rights reserved.
//

import XCTest

class RxSocialConnectExampleUITests: XCTestCase {
    
    let EMAIL = "rxsocialconnect@gmail.com"
    let USERNAME = "rxsocialconnect"
    let PASSWORD = "75r3fehiuwk"
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Tests
    // MARK: - Twitter
    func testConnectWithTwitter() {
        let app = XCUIApplication()
        // Connect
        app.buttons["Close Twitter"].tap()
        sleep(1)
        app.buttons["Twitter"].tap()
        sleep(5)
        app.textFields.elementBoundByIndex(0).tap()
        app.typeText(EMAIL)
        app.toolbars.buttons["Forward"].tap()
        app.typeText(PASSWORD)
        app.buttons["Authorize app"].tap()
        sleep(5)
        app.buttons["OK"].tap()
        
        // Connected
        sleep(1)
        app.buttons["Twitter"].tap()
        sleep(1)
        app.buttons["OK"].tap()
    }
    
    // MARK: - Facebook
    func testConnectWithFacebook() {
        let app = XCUIApplication()
        // Connect
        app.buttons["Close Facebook"].tap()
        sleep(1)
        app.buttons["Facebook"].tap()
        sleep(5)
        app.textFields.elementBoundByIndex(0).tap()
        app.typeText(EMAIL)
        app.toolbars.buttons["Forward"].tap()
        app.typeText(PASSWORD)
        app.buttons["Log In"].tap()
        sleep(5)
        app.buttons["OK"].tap()
        
        // Connected
        sleep(1)
        app.buttons["Facebook"].tap()
        sleep(1)
        app.buttons["OK"].tap()
    }
    
    // MARK: - Instagram
    func testConnectWithInstagram() {
//        let app = XCUIApplication()
//        // Connect
//        app.buttons["Close Instagram"].tap()
//        sleep(1)
//        app.buttons["Instagram"].tap()
//        sleep(5)
//        app.textFields.elementBoundByIndex(0).tap()
//        app.typeText(EMAIL)
//        app.toolbars.buttons["Forward"].tap()
//        app.typeText(PASSWORD)
//        app.buttons["Log in"].tap()
//        sleep(5)
//        app.buttons["OK"].tap()
        
//        // Connected
//        sleep(1)
//        app.buttons["Instagram"].tap()
//        sleep(1)
//        app.buttons["OK"].tap()
    }
    
    // MARK: - Google
    func testConnectWithGoogle() {
//        let app = XCUIApplication()
//        // Connect
//        app.buttons["Close Google"].tap()
//        sleep(1)
//        app.buttons["Google"].tap()
//        sleep(5)
//        app.textFields.elementBoundByIndex(0).tap()
//        app.typeText(EMAIL)
//        app.buttons["Next"].tap()
//        sleep(5)
//        app.textFields.elementBoundByIndex(0).tap()
//        app.typeText(PASSWORD)
//        app.buttons["Sign In"].tap()
//        sleep(5)
//        app.buttons["OK"].tap()
        
//        // Connected
//        sleep(1)
//        app.buttons["Google"].tap()
//        sleep(1)
//        app.buttons["OK"].tap()
    }
    
    // MARK: - Linkedin
    func testConnectWithLinkedin() {
        let app = XCUIApplication()
        // Connect
        app.buttons["Close Linkedin"].tap()
        sleep(1)
        app.buttons["Linkedin"].tap()
        sleep(5)
        app.textFields.elementBoundByIndex(0).tap()
        app.typeText(EMAIL)
        app.toolbars.buttons["Forward"].tap()
        app.typeText(PASSWORD)
        app.buttons["Sign in and allow"].tap()
        sleep(5)
        app.buttons["OK"].tap()
        
        // Connected
        sleep(1)
        app.buttons["Linkedin"].tap()
        sleep(1)
        app.buttons["OK"].tap()
    }
    
    // MARK: - Disconnect
    func testDisconnnectAll() {
        let app = XCUIApplication()
        app.buttons["Close all"].tap()
        sleep(1)
        app.buttons["Twitter"].tap()
        sleep(1)
        assert(app.buttons["OK"].exists == false)
    }
    
}
