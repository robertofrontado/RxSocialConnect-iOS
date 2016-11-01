//
//  FacebookApiMoya.swift
//  RxSocialConnectExample
//
//  Created by Roberto Frontado on 5/25/16.
//  Copyright © 2016 Roberto Frontado. All rights reserved.
//

import RxSwift
import Moya

// MARK: - Endpoint Closure
let endpointClosure = { (target: Target) -> Endpoint<Target> in
    let endpoint: Endpoint<Target> = Endpoint<Target>(URL: url(target), sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters, parameterEncoding: target.parameterEncoding)
    // Add this line to add OAuthHeaders
    return RxSocialConnect.addOAuthHeaders(FacebookApi20.self, endpoint: endpoint)
}

class FacebookApiMoya: NSObject {
    
    // MARK: - Provider setup
    private let provider = RxMoyaProvider<Target>(endpointClosure: endpointClosure)
    
    
    func getMe() -> Observable<Response> {
        return provider.request(Target.me)
    }

}

public enum Target: TargetType {
    case me
    
    public var baseURL: URL {
        return URL(string: "https://graph.facebook.com")!
    }
    
    public var path: String {
        switch self {
        case .me:
            return "/me"
        }
    }
    
    public var method: Moya.Method {
        switch(self) {
        case .me:
            return .get
        }
    }
    
    public var parameters: [String : Any]? {
        return nil
    }
    
    public var parameterEncoding: ParameterEncoding {
        switch self {
        case .me:
            return JSONEncoding()
        }
    }
    
    public var task: Task {
        return .request
    }
    
    public var sampleData: Data {
        switch self {
        default:
            return "[{\"name\": \"Repo Name\"}]".data(using: String.Encoding.utf8)!
        }
    }
}


public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
