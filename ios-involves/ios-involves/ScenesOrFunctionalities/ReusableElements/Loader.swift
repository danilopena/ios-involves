//
//  Loader.swift
//  ios-involves
//
//  Created by Danilo Pena on 20/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

class Loader: NSObject {
    
    /// Shows the pattern loader.
    static func showDefaultLoader() {
        let overlayInvisible = UIView()
        overlayInvisible.frame = UIScreen.main.bounds
        overlayInvisible.center = CGPoint(x: UIScreen.main.bounds.width / 2.0, y: UIScreen.main.bounds.height / 2.0)
        overlayInvisible.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        
        let overlayView = UIView()
        overlayView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        overlayView.center = CGPoint(x: UIScreen.main.bounds.width / 2.0, y: UIScreen.main.bounds.height / 2.0 )
        overlayView.backgroundColor = .white
        overlayView.layer.cornerRadius = 15
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2.0, y: overlayView.bounds.height / 2.0)
        activityIndicator.startAnimating()
        activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        
        overlayView.addSubview(activityIndicator)
        
        overlayView.alpha = 0
        overlayInvisible.restorationIdentifier = "loadingView"
        
        overlayInvisible.addSubview(overlayView)
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(overlayInvisible)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            overlayView.alpha = 1.0
        }, completion: nil)
    }
    
    /// Remove loader from superView
    static func hideDefaultLoading() {
        DispatchQueue.main.async {
            for view in (UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.subviews)! {
                if view.restorationIdentifier == "loadingView" {
                    view.removeFromSuperview()
                }
            }
        }
    }
}
