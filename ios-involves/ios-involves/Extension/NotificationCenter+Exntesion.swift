//
//  NotificationCenter+Exntesion.swift
//  ios-involvesTests
//
//  Created by Danilo Pena on 24/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

extension NotificationCenter {

    /// Adds an observer to the given notification center, which fires just once.
    ///
    /// Note:
    ///  - Same parameters as "addObserver", but with default properties
    ///    See http://apple.co/2zZIYJB for details.
    ///
    /// Parameters:
    ///  - name:   The name of the notification for which to register the observer
    ///  - object: The object whose notifications the observer wants to receive
    ///  - queue:  The operation queue to which block should be added.
    ///  - block:  The block to be executed when the notification is received.
    ///
    func observeOnce(forName name: NSNotification.Name?,
                     object obj: Any? = nil,
                     queue: OperationQueue? = nil,
                     using block: @escaping (Notification) -> Swift.Void) {

        var observer: NSObjectProtocol?
        observer = addObserver(forName: name,
                               object: obj,
                               queue: queue) { [weak self] (notification) in
            defer {
                self?.removeObserver(observer!)
            }

            block(notification)
        }
    }
}
