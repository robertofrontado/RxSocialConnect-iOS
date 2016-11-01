//
//  NotActiveTokenFoundException.swift
//  RxSocialConnect
//
//  Created by Roberto Frontado on 5/23/16.
//  Copyright © 2016 Roberto Frontado. All rights reserved.
//

import Foundation

open class NotActiveTokenFoundException {

    open static let error = NSError(domain: "There is no active token for the provider requested", code: -1, userInfo: nil)
    
}
