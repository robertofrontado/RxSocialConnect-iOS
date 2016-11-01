//
//  RxSocialConnect+Moya.swift
//  RxSocialConnect
//
//  Created by Roberto Frontado on 5/25/16.
//  Copyright © 2016 Roberto Frontado. All rights reserved.
//

import Moya
import OAuthSwift
import RxSwift
import RxBlocking

public extension RxSocialConnect {

    public static func addOAuthHeaders<T: ProviderOAuth1, Target: TargetType>(_ providerOAuth1: T.Type, endpoint: Endpoint<Target>) -> Endpoint<Target>? {
        
        do {
            let credential = try RxSocialConnect.getOAuthCredential(T.self).toBlocking().first()
            let headers = credential!.makeHeaders(URL(string: endpoint.URL)!, method: getOAuthSwiftMethod(endpoint.method), parameters: [:])
            return endpoint.adding(newHttpHeaderFields: headers)
        } catch {
            return endpoint
        }
    }
    
    public static func addOAuthHeaders<T: ProviderOAuth20, Target: TargetType>(_ providerOAuth20: T.Type, endpoint: Endpoint<Target>) -> Endpoint<Target> {

        do {
            let credential = try RxSocialConnect.getOAuthCredential(T.self).toBlocking().first()
            let headers = ["Authorization" : "Bearer \(credential!.oauthToken)"]
            return endpoint.adding(newHttpHeaderFields: headers)
        } catch {
            print(NotActiveTokenFoundException.error.domain)
            return endpoint
        }
    }
        
    // MARK: - Private methods
    fileprivate static func getOAuthSwiftMethod(_ oAuthMethod: Moya.Method) -> OAuthSwiftHTTPRequest.Method {
        switch(oAuthMethod) {
        case .get:
            return .GET
        case .post:
            return .POST
        case .put:
            return .PUT
        case .delete:
            return .DELETE
        case .patch:
            return .PATCH
        case .head:
            return .HEAD
        default:
            return .GET
        }
    }
}
