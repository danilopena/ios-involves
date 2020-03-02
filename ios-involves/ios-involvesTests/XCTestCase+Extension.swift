//
//  XCTestCase+Extension.swift
//  ios-involvesTests
//
//  Created by Danilo Pena on 28/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import XCTest

extension XCTestCase {
    func setupController<T: UIViewController>(storyboardName: String, identifier: String) -> T? {
        guard let vc = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: identifier) as? T else {
            XCTFail("Could not instantiate " + identifier + " from main storyboard")
            return nil
        }
        return vc
    }
}
