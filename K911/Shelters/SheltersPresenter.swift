//
//  SheltersPresenter.swift
//  K911
//
//  Created by Benjamin Bucca on 4/22/19.
//  Copyright © 2019 Benjamin Bucca. All rights reserved.
//

import Foundation

class SheltersPresenter: SheltersPresenterProtocol {
    
    private weak var view: SheltersViewProtocol?
    
    init(view:SheltersViewProtocol) {
        self.view = view
    }
    
    func handleShelterTapped() {
        view?.showPets()
    }
}
