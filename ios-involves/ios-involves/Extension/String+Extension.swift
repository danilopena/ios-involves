//
//  String+Extension.swift
//  ios-involves
//
//  Created by Danilo Pena on 20/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
