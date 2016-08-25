//
//  SCLogin.swift
//  SCDemoApp
//
//  Created by kreative on 8/10/16.
//  Copyright © 2016 kreative. All rights reserved.
//

import Foundation
import FXKeychain

class SCLogin: NSObject {
    class func isLoggined() -> Bool {
        if let _ = FXKeychain.defaultKeychain().objectForKey(Constants.Keychain.tokenKey) {
            return true
        }
        return false
    }
    
    class func getToken() -> String? {
        return FXKeychain.defaultKeychain().objectForKey(Constants.Keychain.tokenKey) as? String
    }
    
    class func setToken(token: String) {
        FXKeychain.defaultKeychain().setObject(token, forKey: Constants.Keychain.tokenKey)
    }
}
