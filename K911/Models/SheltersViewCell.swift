//
//  SheltersViewCell.swift
//  K911
//
//  Created by Benjamin Bucca on 1/2/19.
//  Copyright © 2019 Benjamin Bucca. All rights reserved.
//

import UIKit

class SheltersViewCell: UITableViewCell {

    @IBOutlet weak var shelterName: UILabel!
    @IBOutlet weak var shelterCity: UILabel!
    
    var name: String? {
        didSet{
            self.shelterName.text = name
        }
    }
    
    var city: String? {
        didSet{
            self.shelterCity.text = city
        }
    }
    
}
