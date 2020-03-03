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
        self.layer.cornerRadius = self.frame.height/2
        self.layer.backgroundColor = Color.purple.cgColor
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = Font.futuraBold
    }
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.backgroundColor = Color.purple.cgColor
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = Font.futuraBold
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
