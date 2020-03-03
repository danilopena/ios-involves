//
//  UIButton+Extension.swift
//  ios-involvesTests
//
//  Created by Danilo Pena on 03/03/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit
extension UIButton {
    func buttonActions(controller: UIViewController) -> [String]? {
        return self.actions(forTarget: controller, forControlEvent: .touchUpInside)
    }
}


