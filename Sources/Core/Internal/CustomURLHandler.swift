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

open class CustomURLHandler: NSObject, OAuthSwiftURLHandlerType {
    // Same as OAuthSwift.CallbackNotification.notificationName
    struct CallbackNotification {
        static let notificationName = "OAuthSwiftCallbackNotificationName"
        static let optionsURLKey = "OAuthSwiftCallbackNotificationOptionsURLKey"
    }
    
    open let viewController: UIViewController
    open let callbackUrl: URL
    fileprivate var controller: UINavigationController!
    var observers = [String: AnyObject]()
    
    // configure
    open var animated: Bool = true
    
    // delegates
    open var presentCompletion: (() -> Void)?
    open var dismissCompletion: (() -> Void)?
    
    // init
    public init(viewController: UIViewController, callbackUrl: URL) {
        self.viewController = viewController
        self.callbackUrl = callbackUrl
    }
    
    @objc open func handle(_ url: URL) {
        
        let customWebVC = CustomWebViewController()
        customWebVC.url = url
        customWebVC.callbackUrl = callbackUrl
        controller = UINavigationController(rootViewController: customWebVC)
        
        let key = UUID().uuidString
        
        observers[key] = NotificationCenter.default.addObserver(
            forName: NSNotification.Name(rawValue: CallbackNotification.notificationName),
            object: nil,
            queue: OperationQueue.main,
            using:{
                notification in
                
                if let observer = self.observers[key] {
                    NotificationCenter.default.removeObserver(observer)
                    self.observers.removeValue(forKey: key)
                }
                
                if !self.controller.isBeingDismissed {
                    self.controller.dismiss(animated: self.animated, completion: self.dismissCompletion)
                }
            }
        )
        
        viewController.present(self.controller, animated: self.animated, completion: self.presentCompletion)
    }
    
}

class CustomWebViewController: UIViewController, UIWebViewDelegate {

    var url: URL!
    var callbackUrl: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpWebView()
    }
    
    fileprivate func setUpNavigationBar() {
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(CustomWebViewController.backButtonPressed(_:)))
        navigationItem.leftBarButtonItem = backButton
        self.title = url.host!
    }
    
    fileprivate func setUpWebView() {
        let webView = UIWebView(frame: UIScreen.main.bounds)
        webView.scalesPageToFit = true
        webView.delegate = self
        view.addSubview(webView)
        
        let cookieJar = HTTPCookieStorage.shared
        
        for cookie in cookieJar.cookies! {
            cookieJar.deleteCookie(cookie)
        }
        
        webView.loadRequest(URLRequest(url:url))
    }
    
    // MARK: - Actions
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UIWebViewDelegate
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let url = request.url , url.absoluteString.hasPrefix(callbackUrl.absoluteString) {
            if let nvc = navigationController , !nvc.isBeingDismissed {
                nvc.dismiss(animated: true, completion: { OAuthSwift.handle(url: url) })
            }
        }
        return true
    }
    
}
