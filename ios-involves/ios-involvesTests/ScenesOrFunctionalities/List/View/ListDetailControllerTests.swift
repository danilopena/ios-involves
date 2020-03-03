//
//  ListDetailControllerTests.swift
//  ios-involvesTests
//
//  Created by Danilo Pena on 02/03/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import XCTest
import TraktKit

@testable import ios_involves

class ListDetailControllerTests: XCTestCase {

    var controller: ListDetailController!

    override func setUp() {
        controller = setupController(storyboardName: "List", identifier: ControllerIdentifier.listDetailController)
        let mockList = "{\"name\":\"MyList\",\"description\":\"\",\"privacy\":\"public\",\"display_numbers\":false,\"allow_comments\":true,\"sort_by\":\"rank\",\"sort_how\":\"asc\",\"created_at\":0,\"updated_at\":0,\"item_count\":6,\"comment_count\":0,\"likes\":0,\"ids\":{\"trakt\":4834927,\"slug\":\"mylist\"}}"
        do {
            controller.listToDetail = try JSONDecoder().decode(TraktList.self, from: mockList.data(using: .utf8)!)
        } catch {
            XCTFail("Fail to decode TraktList")
        }
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
        XCTAssertTrue(identifiers.contains(SegueIdentifier.sendToDetailShow), "Segue sendToDetailShow should exist.")
    }

}
