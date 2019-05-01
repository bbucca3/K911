//
//  K911Tests.swift
//  K911Tests
//
//  Created by Benjamin Bucca on 4/28/19.
//  Copyright © 2019 Benjamin Bucca. All rights reserved.
//

import XCTest
@testable import K911

class K911Tests: XCTestCase {
    
    var searchPresenter: SearchPresenter!
    var mockSearchView: SearchViewMock!

    override func setUp() {
        super.setUp()
        mockSearchView = SearchViewMock()
        searchPresenter = SearchPresenter(view: mockSearchView)
    }

    func testSearchTappedSuccess() {
        searchPresenter.handleSearchTapped()
        XCTAssertEqual(1, mockSearchView.showSearchResultsCalledCount)
    }
    
    func testSearchTappedFail() {
        mockSearchView.mockZipCode = "fail"
        searchPresenter.handleSearchTapped()
        XCTAssertEqual(0, mockSearchView.showSearchResultsCalledCount)
    }

}
