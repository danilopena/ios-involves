//
//  ShowSeasonsAndEpisodesViewModelTests.swift
//  ios-involvesTests
//
//  Created by Danilo Pena on 03/03/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import XCTest
import TraktKit

@testable import ios_involves

class ShowSeasonsAndEpisodesViewModelTests: XCTestCase {

    private var showSeasonsAndEpisodesViewModel: ShowSeasonsAndEpisodesViewModel!
    
    override func setUp() {
        showSeasonsAndEpisodesViewModel = ShowSeasonsAndEpisodesViewModel(delegate: self)
    }

    override func tearDown() {
        showSeasonsAndEpisodesViewModel = nil
    }
    
    func testStrings() {
        XCTAssertTrue("seasonsAndEpisodes.title" == ShowSeasonsAndEpisodesViewModel.Localizable.controllerTitle)
        XCTAssertTrue("seasonsAndEpisodes.season" == ShowSeasonsAndEpisodesViewModel.Localizable.season)   
    }
}

extension ShowSeasonsAndEpisodesViewModelTests: StatusDelegate {
    func loaded(status: Status) {}
}
