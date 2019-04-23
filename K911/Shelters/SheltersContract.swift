//
//  SheltersContract.swift
//  K911
//
//  Created by Benjamin Bucca on 4/22/19.
//  Copyright © 2019 Benjamin Bucca. All rights reserved.
//

import Foundation

protocol SheltersViewProtocol: class {
    func showPets()
}

protocol SheltersPresenterProtocol: class {
    func handleShelterTapped()
}
