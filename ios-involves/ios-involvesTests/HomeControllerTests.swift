//
//  HomeControllerTests.swift
//  ios-involvesTests
//
//  Created by Danilo Pena on 24/02/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import XCTest

@testable import ios_involves

class HomeControllerTests: XCTestCase {

    var controller: HomeViewController!
    var notificationCenter: NotificationCenter!

    override func setUp() {
        super.setUp()

        controller = setupController(storyboardName: "Main", identifier: ControllerIdentifier.homeViewController)

        controller.loadViewIfNeeded()
        notificationCenter = NotificationCenter()
    }

    override func tearDown() {
        notificationCenter = nil
        controller = nil
    }
    
    func testNotificationReceived() {
        let expect = expectation(description: "Should receive notification")

        notificationCenter.observeOnce(forName: .TraktSignedIn) { (_ : Notification) in
            expect.fulfill()
        }
        
        notificationCenter.post(name: .TraktSignedIn, object: nil)
        wait(
            for: [expect],
            timeout: TimeInterval(0.1)
        )
    }
    
    func testSegueForLoggedArea() {
        let identifiers = controller.segues()
        XCTAssertTrue(identifiers.contains(SegueIdentifier.sendToLoggedArea), "Segue sendToLoggedArea should exist.")
    }
    
    func testIsJamesCircled() {
        let jamesCornerRadius = controller.jamesPicture.layer.cornerRadius
        let jamesWidthOrHeight = controller.jamesPicture.frame.width
        XCTAssertTrue(jamesCornerRadius == jamesWidthOrHeight / 2)
    }
}
