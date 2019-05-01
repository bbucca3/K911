//
//  SearchViewMock.swift
//  K911
//
//  Created by Benjamin Bucca on 4/30/19.
//  Copyright © 2019 Benjamin Bucca. All rights reserved.
//

import UIKit

class SearchViewMock: SearchViewProtocol {
    
    var showSearchResultsCalledCount = 0
    var mockZipCode = "90210"
    
    func getZipCode() -> String? {
        return mockZipCode
    }
    
    func showSearchResults() {
        if mockZipCode.count == 5 {
            showSearchResultsCalledCount += 1
        }
    }
}

