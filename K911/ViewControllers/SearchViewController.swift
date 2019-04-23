//
//  SearchViewController.swift
//  K911
//
//  Created by Benjamin Bucca on 12/14/18.
//  Copyright © 2018 Benjamin Bucca. All rights reserved.
//

import UIKit

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
        print("entered \(zipCodeTextField.text ?? "")")
        
        presenter?.handleSearchTapped()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kShowShelters {
            let sheltersVC = segue.destination as! SheltersViewController
            sheltersVC.zipCode = zipCodeTextField.text!
        }
    }
    
}

extension SearchViewController: SearchViewProtocol {
    func getZip() -> String? {
        return self.zipCodeTextField.text
    }
    
    func showShelters() {
        performSegue(withIdentifier: kShowShelters, sender: self)
    }
}

