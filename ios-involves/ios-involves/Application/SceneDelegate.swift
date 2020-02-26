//
//  SceneDelegate.swift
//  ios-involves
//
//  Created by Danilo Pena on 20/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit
import TraktKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        let queryDict = URLContexts.first?.url.queryDict() // Parse URL

        if URLContexts.first?.url.host == "auth",
            let code = queryDict?["code"] as? String { // Get authorization code
            do {
                try TraktManager.sharedManager.getTokenFromAuthorizationCode(code: code) { result in
                    switch result {
                    case .success:
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: .TraktSignedIn, object: nil)
                        }
                    case .fail:
                        print("Failed to sign in to Trakt")
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

