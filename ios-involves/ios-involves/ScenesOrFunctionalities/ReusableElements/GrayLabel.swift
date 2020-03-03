//
//  GrayLabel.swift
//  ios-involves
//
//  Created by Danilo Pena on 02/03/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

@IBDesignable
class GrayLabel: UILabel {

    @IBInspectable var isBolded: Bool = false
    @IBInspectable var color: UIColor = Color.gray {
        didSet {
            self.textColor = color
        }
    }
    
    func setup() {
        if isBolded {
            self.font = Font.futuraBold
        } else {
            self.font = Font.futuraMedium
        }
    }
    
    override func awakeFromNib() {
            super.awakeFromNib()
            setup()
        }
    override func layoutSubviews() {
            super.layoutSubviews()
            setup()
        }
    override func prepareForInterfaceBuilder() {
            super.prepareForInterfaceBuilder()
            setup()
        }
}
