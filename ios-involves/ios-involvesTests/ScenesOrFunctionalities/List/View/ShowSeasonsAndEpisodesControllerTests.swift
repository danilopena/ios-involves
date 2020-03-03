//
//  ShowSeasonsAndEpisodesControllerTests.swift
//  ios-involvesTests
//
//  Created by Danilo Pena on 03/03/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import XCTest
import TraktKit

@testable import ios_involves

class ShowSeasonsAndEpisodesControllerTests: XCTestCase {

    var controller: ShowSeasonsAndEpisodesController!

    override func setUp() {
        controller = setupController(storyboardName: "List", identifier: ControllerIdentifier.showSeasonsAndEpisodesController)
        controller.loadViewIfNeeded()
    }

    override func tearDown() {
        controller = nil
    }
    
    func testHasTableView() {
        XCTAssertNotNil(controller.tableView,
                        "Controller should have a tableview")
    }
    
    func testNavigationTitle() {
        XCTAssert(controller.navigationItem.title == controller.showSeasonsAndEpisodesViewModel.controllerTitleString)
    }
}
