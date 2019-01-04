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
    
    let SHELTER_URL: String = "http://api.petfinder.com/shelter.find"
    let API_KEY: String = Petfinder().token
    var allSheltersArray = [Shelter]()
    var selectedShelterId: String?
    var zipCode: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let fiveDigitZipCode = zipCode {
            if fiveDigitZipCode.count != 5 {
                print("Did not enter 5 digit zip")
            } else {
                findShelters(url: SHELTER_URL, zip: fiveDigitZipCode)
            }
        }
    }

    // MARK: - TableView DataSource Methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSheltersArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "shelter", for: indexPath) as! SheltersViewCell

        let shelter = allSheltersArray[indexPath.row]
        
        cell.name = shelter.name
        cell.city = shelter.city
        
//        cell.textLabel?.text = shelter.name

        return cell
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
        
        let shelter = allSheltersArray[indexPath.row]
        selectedShelterId = shelter.id
        performSegue(withIdentifier: "showPets", sender: self)
    }

    // MARK: - Networking Functions
    
    fileprivate func findShelters(url: String, zip: String) {
        
        let params: [String : Any] = ["key" : API_KEY, "location" : zip, "format" : "json", "offset" : 0]
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON {
            response in
            if response.result.isSuccess {
                if let value = response.result.value {
                    let sheltersJSON: JSON = JSON(value)
                    self.updateSheltersData(json: sheltersJSON)
                }
            }
            else {
                print("findShelters Error \(String(describing: response.result.error))")
            }
        }
    }
    
    // MARK: - JSON Parsing
    
    fileprivate func updateSheltersData(json: JSON) {
        
        if let shelters = json.dictionaryValue["petfinder"]?["shelters"]["shelter"] {
            
            for (_, shelter) in shelters {
                let currentShelter = Shelter(json: shelter)
                self.allSheltersArray.append(currentShelter)
            }
        }
        
        tableView.reloadData()
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
