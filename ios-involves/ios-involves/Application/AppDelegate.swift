//
//  AppDelegate.swift
//  ios-involves
//
//  Created by Danilo Pena on 20/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit
import TraktKit

extension Notification.Name {
    static let TraktSignedIn = Notification.Name(rawValue: "TraktSignedIn")
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private struct Constants {
        static let clientId = "66abc8aac495d8bd02b446198198bf2a6e1c1ec3f793fbde819cd65e4731cdd2"
        static let clientSecret = "f57dbaab610e3bfb756111a0174b369c9cb8d691d746214e1e5ad46171614a68"
        static let redirectURI = "traktinvolves://auth/trakt"
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        TraktManager.sharedManager.set(clientID:     Constants.clientId,
                                       clientSecret: Constants.clientSecret,
                                       redirectURI:  Constants.redirectURI,
                                       staging: true)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}

