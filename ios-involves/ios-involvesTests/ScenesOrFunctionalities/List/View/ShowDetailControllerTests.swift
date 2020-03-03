//
//  ShowDetailControllerTests.swift
//  ios-involvesTests
//
//  Created by Danilo Pena on 03/03/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import XCTest

@testable import ios_involves

class ShowDetailControllerTests: XCTestCase {

    var controller: ShowDetailController!

    override func setUp() {
        controller = setupController(storyboardName: "List", identifier: ControllerIdentifier.showDetailController)
        controller.loadViewIfNeeded()
    }

    override func tearDown() {
        controller = nil
    }

    func testSegueForListItems() {
        let identifiers = controller.segues()
        XCTAssertTrue(identifiers.contains(SegueIdentifier.sendToSeasonsAndEpisodes), "Segue sendToSeasonsAndEpisodes should exist.")
    }
    
    func testElementColors() {
        controller.setupLayout()
        XCTAssert(controller.separatorView.backgroundColor == Color.purple)
        XCTAssert(controller.orientationEpisode.textColor == Color.purple)
    }
    
    /// This test uses Keywindow because the controller is not in view hierarchy to present an alert.
    func testCanSendAlertInErrorCase() {
        let keyWindow = getKeywindow()
        
        keyWindow?.rootViewController?.presentedViewController?.alert(message: "Test alert", completion: {})
        let expectation = XCTestExpectation(description: "After 1.5 seconds one alert needs to be presented")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {            XCTAssert(keyWindow?.rootViewController?.presentedViewController?.presentedViewController is UIAlertController)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testSeasonsAndEpisodesButtonInit() {
        XCTAssertNotNil(controller.seasonAndEpisodes)
    }
    
    func testSeasonsAndEpisodesAction() {
        let actions = controller.seasonAndEpisodes.buttonActions(controller: controller)

        XCTAssertNotNil(actions)
        if let actions = actions {
            XCTAssert(actions.count > 0)
            XCTAssert(actions.contains("showSeasonsAndEpisodes"))
        }
    }
}

extension ShowDetailControllerTests {
    func getKeywindow() -> UIWindow? {
        return UIApplication.shared.connectedScenes
                                .filter({$0.activationState == .foregroundActive})
                                .map({$0 as? UIWindowScene})
                                .compactMap({$0})
                                .first?.windows
                                .filter({$0.isKeyWindow}).first

    }
}
