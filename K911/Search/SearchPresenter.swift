//
//  SearchPresenter.swift
//  K911
//
//  Created by Benjamin Bucca on 4/22/19.
//  Copyright © 2019 Benjamin Bucca. All rights reserved.
//

import Foundation

protocol SearchPresenterProtocol: class {
    func handleSearchTapped()
}

class SearchPresenter: SearchPresenterProtocol {
    
    private weak var view:SearchViewProtocol?
    
    init(view:SearchViewProtocol) {
        self.view = view
    }
    
    func handleSearchTapped() {
        if let zip = view?.getZipCode(), zip.count == 5 {
            view?.showSearchResults()
        }
    }
}
