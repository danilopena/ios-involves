//
//  SeriesListControllerTests.swift
//  ios-involvesTests
//
//  Created by Danilo Pena on 27/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import XCTest

@testable import ios_involves

class ListControllerTests: XCTestCase {

    var controller: ListController!

    override func setUp() {
        controller = setupController(storyboardName: "List", identifier: ControllerIdentifier.listController)
        controller.loadViewIfNeeded()
    }

    override func tearDown() {
        controller = nil
    }
    
    func testHasTableView() {
        XCTAssertNotNil(controller.tableView,
                        "Controller should have a tableview")
    }

    func testSegueForListItems() {
        let identifiers = controller.segues()
        XCTAssertTrue(identifiers.contains(SegueIdentifier.sendToListItems), "Segue sendToListItems should exist.")
    }
}
