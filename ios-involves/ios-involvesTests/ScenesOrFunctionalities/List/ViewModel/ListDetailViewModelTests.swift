//
//  ListDetailViewModelTests.swift
//  ios-involvesTests
//
//  Created by Danilo Pena on 03/03/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import XCTest


@testable import ios_involves

class ListDetailViewModelTests: XCTestCase {

    private var listDetailViewModel: ListDetailViewModel!
        
    override func setUp() {
        listDetailViewModel = ListDetailViewModel(delegate: self)
    }

    override func tearDown() {
        listDetailViewModel = nil
    }
    
    func testStrings() {
        XCTAssertTrue("error.message.unknown" == ListDetailViewModel.Localizable.errorUnknown)
    }
}

extension ListDetailViewModelTests: StatusDelegate {
    func loaded(status: Status) {}
}
