//
//  RoundedButton.swift
//  ios-involves
//
//  Created by Danilo Pena on 20/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

    override func prepareForInterfaceBuilder() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
            self.layer.borderColor = Colors.blue.cgColor
        self.setTitleColor(Colors.blue, for: .normal)
        self.titleLabel?.font = UIFont(name: Fonts.futuraBold, size: 18)
    }
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
            self.layer.borderColor = Colors.blue.cgColor
        self.setTitleColor(Colors.blue, for: .normal)
        self.titleLabel?.font = UIFont(name: Fonts.futuraBold, size: 18)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
