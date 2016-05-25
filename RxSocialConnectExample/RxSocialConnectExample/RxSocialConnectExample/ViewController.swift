//
//  ViewController.swift
//  RxSocialConnectExample
//
//  Created by Roberto Frontado on 5/18/16.
//  Copyright © 2016 Roberto Frontado. All rights reserved.
//

import UIKit
import OAuthSwift

class ViewController: UIViewController {
    
    let facebookApiMoya = FacebookApiMoya()
    
    // MARK: - Private methods
    private func showResponse(credential: OAuthSwiftCredential) {
        showAlert("Token: " + credential.oauth_token)
    }
    
    private func showError(error: NSError) {
        showAlert(error.domain)
    }
    
    private func showAlert(message: String) {
        let alertVC = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alertVC, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    // MARK: Twitter
    @IBAction func twitterButtonPressed(sender: UIButton) {
        let twitterApi = TwitterApi(
            consumerKey: "vAhn2cfWhhtpe0ajlr1w",
            consumerSecret: "JdN0FArC43ZV8Tk9AIG52hfmbU5NE1SUwmnNBzg",
            callbackUrl: NSURL(string: "oauth-swift://oauth-callback/twitter")!
        )
        
        RxSocialConnect.with(self, providerOAuth1: twitterApi)
            .subscribe(onNext: { self.showResponse($0) },
                onError: { self.showError($0 as NSError) })
    }
    
    @IBAction func disconnectTwitterButtonPressed(sender: UIButton) {
        RxSocialConnect.closeConnection(TwitterApi.self).subscribe()
    }
    
    // MARK: Facebook
    @IBAction func facebookButtonPressed(sender: UIButton) {
        let facebookApi20 = FacebookApi20(
            consumerKey: "452930454916873",
            consumerSecret: "4a643dd4c4537f01411ab7bb44736f1f",
            callbackUrl: NSURL(string: "http://victoralbertos.com/")!,
            scope: "public_profile"
        )
        
        RxSocialConnect.with(self, providerOAuth20: facebookApi20)
            .subscribe(onNext: { credential in
                self.showResponse(credential)
                // Testing Facebook
                self.facebookApiMoya.getMe()
                    .subscribe(onNext: { (response) -> Void in
                        print(NSString(data: response.data, encoding: NSUTF8StringEncoding))
                        }, onError: { self.showError($0 as NSError) })
                },
                onError: { self.showError($0 as NSError) })
    }
    
    @IBAction func disconnectFacebookButtonPressed(sender: UIButton) {
        RxSocialConnect.closeConnection(FacebookApi20.self).subscribe()
    }
    
    // MARK: Instagram
    @IBAction func instagramButtonPressed(sender: UIButton) {
        let instagramApi20 = InstagramApi20(
            consumerKey: "d5d68c4d1d7241d2afefece62157af64",
            consumerSecret: "768dfdf88bb1479f9ae706da694c3576",
            callbackUrl: NSURL(string: "oauth-swift://oauth-callback/instagram")!,
            scope: "basic"
        )
        
        RxSocialConnect.with(self, providerOAuth20: instagramApi20)
            .subscribe(onNext: { self.showResponse($0) },
                onError: { self.showError($0 as NSError) })
    }
    
    @IBAction func disconnectInstagramButtonPressed(sender: UIButton) {
        RxSocialConnect.closeConnection(InstagramApi20.self).subscribe()
    }
    
    // MARK: Google
    @IBAction func googleButtonPressed(sender: UIButton) {
        let googleApi20 = GoogleApi20(
            consumerKey: "112202070176-3b8b2s85rtt39k6ga5f2001p937i57fq.apps.googleusercontent.com",
            consumerSecret: "-zkjJwn3j_2JOyPSDHExJ6cO",
            callbackUrl: NSURL(string: "http://victoralbertos.com/")!,
            scope: "profile"
        )
        
        RxSocialConnect.with(self, providerOAuth20: googleApi20)
            .subscribe(onNext: { self.showResponse($0) },
                onError: { self.showError($0 as NSError) })
    }
    
    @IBAction func disconnectGoogleButtonPressed(sender: UIButton) {
        RxSocialConnect.closeConnection(GoogleApi20.self).subscribe()
    }
    
    // MARK: Linkedin
    @IBAction func linkedinButtonPressed(sender: UIButton) {
        let linkedinApi20 = LinkedinApi20(
            consumerKey: "77u9plrpoq0g6t",
            consumerSecret: "VlH229TNkzJysxbq",
            callbackUrl: NSURL(string: "http://victoralbertos.com")!,
            scope: "r_basicprofile"
        )
        
        RxSocialConnect.with(self, providerOAuth20: linkedinApi20)
            .subscribe(onNext: { self.showResponse($0) },
                onError: { self.showError($0 as NSError) })
    }
    
    @IBAction func disconnectLinkedinButtonPressed(sender: UIButton) {
        RxSocialConnect.closeConnection(LinkedinApi20.self).subscribe()
    }
    
    // MARK: Disconnect all
    @IBAction func disconnectAllButtonPressed(sender: UIButton) {
        RxSocialConnect.closeConnections().subscribe()
    }

    
}

