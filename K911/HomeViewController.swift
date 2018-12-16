//
//  HomeViewController.swift
//  K911
//
//  Created by Benjamin Bucca on 12/14/18.
//  Copyright © 2018 Benjamin Bucca. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        print("entered \(zipCodeTextField.text ?? "")")
        
        performSegue(withIdentifier: "showShelters", sender: self)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showShelters" {
            let sheltersVC = segue.destination as! SheltersViewController
            sheltersVC.zipCode = zipCodeTextField.text!
        }
    }
    
}

