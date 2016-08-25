//
//  LoginViewController.swift
//  YouTubePlayerApp
//
//  Created by kreative on 8/22/16.
//  Copyright © 2016 kreative. All rights reserved.
//

import Foundation
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    
    @IBAction func loginTouch(sender: AnyObject) {
        GIDSignIn.sharedInstance().scopes = ["https://gdata.youtube.com"]
        GIDSignIn.sharedInstance().clientID = "300774388973-e66r27fl05p7bikif5gj4ege9kmi8bol.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if (error == nil) {
            let userId = user.userID
            let idToken = user.authentication.idToken
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            let accessToken = user.authentication.accessToken
            
            print("userId \(userId)")
            print("idToken \(idToken)")
            print("fullName \(fullName)")
            print("givenName \(givenName)")
            print("familyName \(familyName)")
            print("email \(email)")
            
            SCLogin.setToken(accessToken)
            
            if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate {
                delegate.showSudscription()
            }
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!, withError error: NSError!) {
        //
    }
    
    
}

//dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(UInt64(3) * NSEC_PER_SEC)), dispatch_get_main_queue()) {
//    dispatch_async(dispatch_get_main_queue(), {
//        (UIApplication.sharedApplication().delegate as! AppDelegate).showSudscription()
//    })
//}

