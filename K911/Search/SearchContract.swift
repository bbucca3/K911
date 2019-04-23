//
//  SearchContract.swift
//  K911
//
//  Created by Benjamin Bucca on 4/22/19.
//  Copyright © 2019 Benjamin Bucca. All rights reserved.
//

import Foundation

protocol SearchViewProtocol: class {
    func getZip() -> String?
    func showShelters()
}

protocol SearchPresenterProtocol: class {
    func handleSearchTapped()
}
