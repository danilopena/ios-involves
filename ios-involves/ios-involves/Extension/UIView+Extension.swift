//
//  UIView+Extension.swift
//  ios-involves
//
//  Created by Danilo Pena on 24/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

extension UIView {
    
    func makeCircle() {
        self.layer.cornerRadius = self.frame.width/2
    }
}
