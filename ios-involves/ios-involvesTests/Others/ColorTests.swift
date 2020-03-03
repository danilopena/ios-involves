//
//  ColorTests.swift
//  ios-involvesTests
//
//  Created by Danilo Pena on 02/03/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import XCTest

class ColorTests: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {
    
    }

    func testColorsHex() {
        XCTAssertTrue(hexStringFromColor(color: Color.gray)   == "#424242")
        XCTAssertTrue(hexStringFromColor(color: Color.red)    == "#FD494A")
        XCTAssertTrue(hexStringFromColor(color: Color.purple) == "#1F0E3D")
        XCTAssertTrue(hexStringFromColor(color: Color.black)  == "#141414")
    }
    
    func hexStringFromColor(color: UIColor) -> String {
       let components = color.cgColor.components
       let r: CGFloat = components?[0] ?? 0.0
       let g: CGFloat = components?[1] ?? 0.0
       let b: CGFloat = components?[2] ?? 0.0

       let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
       print(hexString)
       return hexString
    }
}
