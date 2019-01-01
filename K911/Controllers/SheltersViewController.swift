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
    let API_KEY = Petfinder().token
    var zipCode: String?
    var allSheltersArray = [Shelter]()

    override func viewDidLoad() {
        super.viewDidLoad()
        findShelters(url: SHELTER_URL, zip: zipCode!)
    }

    // MARK: - TableView Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allSheltersArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shelterCell", for: indexPath)

        let item = allSheltersArray[indexPath.row]
        
        cell.textLabel?.text = item.name

        return cell
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
                print("Error \(String(describing: response.result.error))")
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
        
        print(allSheltersArray)
        tableView.reloadData()
    }

}
