//
//  PetDetailViewController.swift
//  K911
//
//  Created by Benjamin Bucca on 1/5/19.
//  Copyright © 2019 Benjamin Bucca. All rights reserved.
//

import UIKit

class PetDetailViewController: UIViewController {
    
    var pet: Pet?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let thisPet = pet {
            print("BSB \(thisPet)")
        }
        
    }

}
