//
//  HomeViewController.swift
//  K911
//
//  Created by Benjamin Bucca on 12/14/18.
//  Copyright © 2018 Benjamin Bucca. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var zipCodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        print("entered \(zipCodeTextField.text ?? "")")
        
        performSegue(withIdentifier: "showShelters", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showShelters" {
            print("showing shelters")
            let sheltersVC = segue.destination as! SheltersViewController
            sheltersVC.zipCode = zipCodeTextField.text!
        }
    }
    
}

