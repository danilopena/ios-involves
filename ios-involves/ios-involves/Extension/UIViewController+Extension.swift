//
//  UIViewController+Extension.swift
//  ios-involves
//
//  Created by Danilo Pena on 20/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Prompt a simple alert.
    func alert(title: String = "", message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true) {
            completion()
        }
    }
    
    /// Get a list of string segues.
    func segues() -> [String] {
        let identifiers = (self.value(forKey: "storyboardSegueTemplates") as? [AnyObject])?.compactMap({ $0.value(forKey: "identifier") as? String }) ?? []
        return identifiers
    }
}
