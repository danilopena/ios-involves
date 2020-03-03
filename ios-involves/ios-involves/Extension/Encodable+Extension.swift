//
//  Encodable+Extension.swift
//  ios-involves
//
//  Created by Danilo Pena on 03/03/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
          throw NSError()
        }
        return dictionary
    }
}
