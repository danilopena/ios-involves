//
//  ItemTypeEnum.swift
//  ios-involves
//
//  Created by Danilo Pena on 28/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

enum ItemTypeEnum: String {
    case movie = "movie"
    case show  = "show"
    case none
    
    func localizedTitle() -> String {
        switch self {
        case .movie:
            return Localizable.movie.localized
        case .show:
            return Localizable.show.localized
        case .none:
            return Localizable.none.localized
        }
    }
    
    /// Based on type, will present a specific image.
    func getImage() -> UIImage {
        switch self {
        case .show:
            return #imageLiteral(resourceName: "show-icon")
        case .movie:
            return #imageLiteral(resourceName: "movie-icon")
        case .none:
            return #imageLiteral(resourceName: "others-icon")
        }
    }
}

private extension ItemTypeEnum {
    private enum Localizable {
        static let movie = "title.movie"
        static let show  = "title.show"
        static let none  = "title.none"
    }
}
