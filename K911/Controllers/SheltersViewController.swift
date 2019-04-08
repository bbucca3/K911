//
//  SheltersViewController.swift
//  K911
//
//  Created by Benjamin Bucca on 12/15/18.
//  Copyright © 2018 Benjamin Bucca. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SheltersViewController: UITableViewController {
    
    // MARK: - Properties
    
    let dataSource = SheltersDataSource()
    let SHELTER_URL: String = "http://api.petfinder.com/shelter.find"
    
    var selectedShelterId: String?
    var zipCode: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.dataChanged = { [weak self] in
            self?.tableView.reloadData()
        }
        
        if let fiveDigitZipCode = zipCode {
            if fiveDigitZipCode.count != 5 {
                print("Did not enter 5 digit zip")
            } else {
                dataSource.fetch(SHELTER_URL, zipCode: fiveDigitZipCode)
            }
        }
        
        tableView.dataSource = dataSource
    }
    
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        
        if let zip = zipCode {
            label.text = "Searched for \(zip)"
        }
        
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let shelter = dataSource.allSheltersArray[indexPath.row]
        selectedShelterId = shelter.id
        performSegue(withIdentifier: "showPets", sender: self)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showPets" {
            let petsVC = segue.destination as! PetsViewController
            if let shelterId = selectedShelterId {
                petsVC.shelterId = shelterId
            }
        }
    }

}
