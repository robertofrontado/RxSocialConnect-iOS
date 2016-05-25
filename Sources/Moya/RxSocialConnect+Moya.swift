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

    public static func addOAuthHeaders<T: ProviderOAuth1, Target: TargetType>(providerOAuth1: T.Type, endpoint: Endpoint<Target>) -> Endpoint<Target>? {
        
        do {
            let credential = try RxSocialConnect.getOAuthCredential(T).toBlocking().first()
            let headers = credential!.makeHeaders(NSURL(string: endpoint.URL)!, method: getOAuthSwiftMethod(endpoint.method), parameters: [:])
            return endpoint.endpointByAddingHTTPHeaderFields(headers)
        } catch {
            return endpoint
        }
    }
    
    public static func addOAuthHeaders<T: ProviderOAuth20, Target: TargetType>(providerOAuth20: T.Type, endpoint: Endpoint<Target>) -> Endpoint<Target> {

        do {
            let credential = try RxSocialConnect.getOAuthCredential(T).toBlocking().first()
            let headers = ["Authorization" : "Bearer \(credential!.oauth_token)"]
            return endpoint.endpointByAddingHTTPHeaderFields(headers)
        } catch {
            print(NotActiveTokenFoundException.error.domain)
            return endpoint
        }
    }
        
    // MARK: - Private methods
    private static func getOAuthSwiftMethod(oAuthMethod: Moya.Method) -> OAuthSwiftHTTPRequest.Method {
        switch(oAuthMethod) {
        case .GET:
            return .GET
        case .POST:
            return .POST
        case .PUT:
            return .PUT
        case .DELETE:
            return .DELETE
        case .PATCH:
            return .PATCH
        case .HEAD:
            return .HEAD
        default:
            return .GET
        }
    }
}
