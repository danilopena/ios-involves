//
//  Movie.swift
//  ios-involves
//
//  Created by Danilo Pena on 20/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

class Movie: Codable {
    var title: String?
    var year:  Int?
    var ids:   Ids?
}

class Ids: Codable {
    var trakt: Int?
    var slug:  String?
    var tvdb:  Int32?
    var imdb:  String?
    var tmdb:  Int32?
}
/*
movie{
    "title": "Batman Begins",
    "year": 2005,
    "ids": {
        "trakt": 1,
        "slug": "batman-begins-2005",
        "imdb": "tt0372784",
        "tmdb": 272
    }
}
show{
    "title": "Breaking Bad",
    "year": 2008,
    "ids": {
        "trakt": 1,
        "slug": "breaking-bad",
        "tvdb": 81189,
        "imdb": "tt0903747",
        "tmdb": 1396
    }
}
season{
    "number": 0,
    "ids": {
        "trakt": 1,
        "tvdb": 439371,
        "tmdb": 3577
    }
}
episode{
    "season": 1,
    "number": 1,
    "title": "Pilot",
    "ids": {
        "trakt": 16,
        "tvdb": 349232,
        "imdb": "tt0959621",
        "tmdb": 62085
    }
}
person{
    "name": "Bryan Cranston",
    "ids": {
        "trakt": 142,
        "slug": "bryan-cranston",
        "imdb": "nm0186505",
        "tmdb": 17419
    }
}
*/
