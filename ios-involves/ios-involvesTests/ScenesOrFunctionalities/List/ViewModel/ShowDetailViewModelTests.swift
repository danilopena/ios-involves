//
//  ShowDetailViewModelTests.swift
//  ios-involvesTests
//
//  Created by Danilo Pena on 03/03/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import XCTest
import TraktKit

@testable import ios_involves

class ShowDetailViewModelTests: XCTestCase {

    private var showDetailViewModel: ShowDetailViewModel!
    
    override func setUp() {
        showDetailViewModel = ShowDetailViewModel(delegate: self)
        
        testDecodeShow()
    }

    override func tearDown() {
        showDetailViewModel = nil
    }
    
    func testStrings() {
        XCTAssertTrue("show.title" == ShowDetailViewModel.Localizable.controllerTitle)
        XCTAssertTrue("list.detail.name" == ShowDetailViewModel.Localizable.showDetailName)
        XCTAssertTrue("list.detail.year" == ShowDetailViewModel.Localizable.showDetailYear)
        XCTAssertTrue("show.detail.season" == ShowDetailViewModel.Localizable.showDetailSeason)
        XCTAssertTrue("show.detail.watched" == ShowDetailViewModel.Localizable.showDetailWatched)
        XCTAssertTrue("show.detail.nextEpisodeOrientation" == ShowDetailViewModel.Localizable.nextEpisodeOrientation)
        XCTAssertTrue("show.detail.lastEpisodeOrientation" == ShowDetailViewModel.Localizable.lastEpisodeOrientation)
        XCTAssertTrue("list.detail.seasonsAndEpisodes" == ShowDetailViewModel.Localizable.seasonsAndEpisodes)
    }
    
    func testDecodeShow() {
        let mockShowProgress = "{\"aired\":10,\"completed\":1,\"last_watched_at\":0,\"reset_at\":null,\"seasons\":[],\"hidden_seasons\":[],\"next_episode\":{\"season\":1,\"number\":7,\"title\":\"A Brown Thanksgiving\",\"ids\":{\"trakt\":8941,\"tvdb\":689501,\"imdb\":null,\"tmdb\":540646,\"tvrage\":777752}},\"last_episode\":{\"season\":4,\"number\":23,\"title\":\"Wheel! Of! Family!\",\"ids\":{\"trakt\":230174,\"tvdb\":4493309,\"imdb\":null,\"tmdb\":null,\"tvrage\":null}}}"
        do {
            showDetailViewModel.show = try JSONDecoder().decode(TraktShowWatchedProgress.self, from: mockShowProgress.data(using: .utf8)!)
        } catch {
            XCTFail("Fail to decode TraktList")
        }
    }
    
    func testNotNilShowProgress() {
        XCTAssertNotNil(showDetailViewModel.show)
    }
    
    func testPercentageShowProgress() {
        XCTAssert(showDetailViewModel.showDetailWatchedString.contains("10%"))
    }
    
    func testDateFormat() {
        XCTAssertTrue(showDetailViewModel.dateFormatString == "dd/MM/yyyy HH:mm:ss", "Right format is (dd/MM/yyyy HH:mm:ss)")
    }
}

extension ShowDetailViewModelTests: ShowDetailViewModelDelegate {
    func loaded(status: Status) {}
    
    func loadedNextEpisode(status: Status) {}
    
    func loadedShowForSeasonsAndEpisodes(status: Status) {}
}
