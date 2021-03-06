//
//  SearchViewController.swift
//  K911
//
//  Created by Benjamin Bucca on 12/14/18.
//  Copyright © 2018 Benjamin Bucca. All rights reserved.
//

import UIKit

protocol SearchViewProtocol: class {
    func getZipCode() -> String?
    func showSearchResults()
}

class SearchViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    var presenter:SearchPresenterProtocol?
    let kShowShelters = "showShelters"
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = SearchPresenter(view: self)
    }

    @IBAction func searchButtonTapped(_ sender: Any) {        
        presenter?.handleSearchTapped()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kShowShelters {
            let sheltersVC = segue.destination as! SheltersViewController
            sheltersVC.zipCode = getZipCode()!
        }
    }
    
}

extension SearchViewController: SearchViewProtocol {
    func getZipCode() -> String? {
        return self.zipCodeTextField.text
    }
    
    func showSearchResults() {
        performSegue(withIdentifier: kShowShelters, sender: self)
    }
}

