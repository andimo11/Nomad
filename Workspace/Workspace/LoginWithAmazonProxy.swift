//
//  AlexaTranslate.swift
//  Workspace
//
//  Created by James touri on 9/17/19.
//  Copyright © 2019 jamestouri. All rights reserved.
//

import Foundation
import LoginWithAmazon

struct Settings {
    struct Credentials {
        static let SCOPES = ["profile"]
    }
}

import LoginWithAmazon

class LoginWithAmazonProxy {

    static let sharedInstance = LoginWithAmazonProxy()

    func login(delegate: AIAuthenticationDelegate) {
        AIMobileLib.authorizeUser(forScopes: Settings.Credentials.SCOPES, delegate: delegate, options: nil)
    }
    
    func logout(delegate: AIAuthenticationDelegate) {
        AIMobileLib.clearAuthorizationState(delegate)
    }
    
    func getAccessToken(delegate: AIAuthenticationDelegate) {
        AIMobileLib.getAccessToken(forScopes: Settings.Credentials.SCOPES, withOverrideParams: nil, delegate: delegate)
    }
}
