 //
//  PetsViewCell.swift
//  K911
//
//  Created by Benjamin Bucca on 1/4/19.
//  Copyright © 2019 Benjamin Bucca. All rights reserved.
//

import UIKit

class PetViewCell: UITableViewCell {

    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petAnimal: UILabel!
    @IBOutlet weak var petSex: UILabel!
    
    var img: UIImage? {
        didSet {
            self.petImage.image = img
        }
    }
    
    var name: String? {
        didSet {
            self.petName.text = name
        }
    }
    
    var animal: String? {
        didSet {
            self.petAnimal.text = animal
        }
    }
    
    var age: String? {
        didSet {
            self.petSex.text = age
        }
    }

}
