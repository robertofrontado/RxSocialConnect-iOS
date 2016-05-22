//
//  CustomURLHandler.swift
//  RxSocialConnect
//
//  Created by Roberto Frontado on 5/19/16.
//  Copyright © 2016 Roberto Frontado. All rights reserved.
//

import UIKit
import WebKit
import OAuthSwift

public class CustomURLHandler: NSObject, OAuthSwiftURLHandlerType {
    // Same as OAuthSwift.CallbackNotification.notificationName
    struct CallbackNotification {
        static let notificationName = "OAuthSwiftCallbackNotificationName"
        static let optionsURLKey = "OAuthSwiftCallbackNotificationOptionsURLKey"
    }
    
    public let viewController: UIViewController
    public let callbackUrl: NSURL
    private var controller: UINavigationController!
    var observers = [String: AnyObject]()
    
    // configure
    public var animated: Bool = true
    
    // delegates
    public var presentCompletion: (() -> Void)?
    public var dismissCompletion: (() -> Void)?
    
    // init
    public init(viewController: UIViewController, callbackUrl: NSURL) {
        self.viewController = viewController
        self.callbackUrl = callbackUrl
    }
    
    @objc public func handle(url: NSURL) {
        
        let customWebVC = CustomWebViewController()
        customWebVC.url = url
        customWebVC.callbackUrl = callbackUrl
        controller = UINavigationController(rootViewController: customWebVC)
        
        let key = NSUUID().UUIDString
        
        observers[key] = NSNotificationCenter.defaultCenter().addObserverForName(
            CallbackNotification.notificationName,
            object: nil,
            queue: NSOperationQueue.mainQueue(),
            usingBlock:{ [unowned self]
                notification in
                if let observer = self.observers[key] {
                    NSNotificationCenter.defaultCenter().removeObserver(observer)
                    self.observers.removeValueForKey(key)
                }
                
                if !self.controller.isBeingDismissed() {
                    self.controller.dismissViewControllerAnimated(self.animated, completion: self.dismissCompletion)
                }
            }
        )
        
        viewController.presentViewController(self.controller, animated: self.animated, completion: self.presentCompletion)
    }
    
}

class CustomWebViewController: UIViewController, UIWebViewDelegate {

    var url: NSURL!
    var callbackUrl: NSURL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpWebView()
    }
    
    private func setUpNavigationBar() {
        let backButton = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: "backButtonPressed:")
        navigationItem.leftBarButtonItem = backButton
        self.title = url.host!
    }
    
    private func setUpWebView() {
        let webView = UIWebView(frame: UIScreen.mainScreen().bounds)
        webView.scalesPageToFit = true
        webView.delegate = self
        view.addSubview(webView)
        
        webView.loadRequest(NSURLRequest(URL:url))
    }
    
    // MARK: - Actions
    @IBAction func backButtonPressed(sender: UIButton) {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - UIWebViewDelegate
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let url = request.URL where url.absoluteString.hasPrefix(callbackUrl.absoluteString) {
            if let nvc = navigationController where !nvc.isBeingDismissed() {
                nvc.dismissViewControllerAnimated(true, completion: { OAuthSwift.handleOpenURL(url) })
            }
        }
        return true
    }
    
}
