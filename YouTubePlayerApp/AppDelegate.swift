//
//  AppDelegate.swift
//  YouTubePlayerApp
//
//  Created by kreative on 8/19/16.
//  Copyright © 2016 kreative. All rights reserved.
//

import UIKit
import GoogleSignIn
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        YTRestKitManager.sharedManager
        
        if let _ = SCLogin.getToken() {
            showSudscription()
        } else {
            showLoginScreen()
        }

        return true
    }
    
    func showLoginScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainScreen = storyboard.instantiateViewControllerWithIdentifier("Login")
        window?.rootViewController = mainScreen
    }
    
    func showSudscription() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let subscriptions = storyboard.instantiateViewControllerWithIdentifier("Subscriptions")
        window?.rootViewController = subscriptions
    }
    
    func application(application: UIApplication,
                     openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        var options: [String: AnyObject] = [UIApplicationOpenURLOptionsSourceApplicationKey: sourceApplication!,
                                            UIApplicationOpenURLOptionsAnnotationKey: annotation]
        return GIDSignIn.sharedInstance().handleURL(url,
                                                    sourceApplication: sourceApplication,
                                                    annotation: annotation)
    }

}

