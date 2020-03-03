//
//  ListViewModelTests.swift
//  ios-involvesTests
//
//  Created by Danilo Pena on 02/03/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import XCTest

@testable import ios_involves

class ListViewModelTests: XCTestCase {

    private var listViewModel: ListViewModel!
    
    override func setUp() {
        listViewModel = ListViewModel(delegate: self)
    }

    override func tearDown() {
        listViewModel = nil
    }
    
    func testStrings() {
        XCTAssertTrue("list.title" == ListViewModel.Localizable.controllerTitle)
        XCTAssertTrue("tabBar.list.title" == ListViewModel.Localizable.tabBarTitle)
        XCTAssertTrue("list.orientation" == ListViewModel.Localizable.orientationList)
    }
}

extension ListViewModelTests: StatusDelegate {
    func loaded(status: Status) {}
}
