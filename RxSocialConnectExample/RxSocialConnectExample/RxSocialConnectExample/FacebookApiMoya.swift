//
//  FacebookApiMoya.swift
//  RxSocialConnectExample
//
//  Created by Roberto Frontado on 5/25/16.
//  Copyright © 2016 Roberto Frontado. All rights reserved.
//

import RxSwift
import OAuthSwift
import Moya

// MARK: - Endpoint Closure
let endpointClosure = { (target: Target) -> Endpoint<Target> in
    let endpoint: Endpoint<Target> = Endpoint<Target>(URL: url(target), sampleResponseClosure: {.NetworkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters, parameterEncoding: target.parameterEncoding)
    // Add this line to add OAuthHeaders
    return RxSocialConnect.addOAuthHeaders(FacebookApi20.self, endpoint: endpoint)
}

class FacebookApiMoya: NSObject {
    
    // MARK: - Provider setup
    private let provider = RxMoyaProvider<Target>(endpointClosure: endpointClosure)
    
    func getMe() -> Observable<Response> {
        return provider.request(Target.Me)
    }

}

public enum Target: TargetType {
    case Me
    
    public var baseURL: NSURL {
        return NSURL(string: "https://graph.facebook.com")!
    }
    
    public var path: String {
        switch(self) {
        case .Me:
            return "/me"
        }
    }
    
    public var method: Moya.Method {
        switch(self) {
        case .Me:
            return .GET
        }
    }
    
    public var parameterEncoding: Moya.ParameterEncoding {
        switch(self) {
        case .Me:
            return .JSON
        }
    }
    
    public var parameters: [String: AnyObject]? {
        return nil
    }
    
    public var sampleData: NSData {
        switch self {
        default:
            return "[{\"name\": \"Repo Name\"}]".dataUsingEncoding(NSUTF8StringEncoding)!
        }
    }
}

public func url(route: TargetType) -> String {
    return route.baseURL.URLByAppendingPathComponent(route.path).absoluteString
}
