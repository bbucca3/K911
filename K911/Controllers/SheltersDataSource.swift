//
//  SheltersDataSource.swift
//  K911
//
//  Created by Benjamin Bucca on 4/7/19.
//  Copyright © 2019 Benjamin Bucca. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SheltersDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Properties
    
    let API_KEY: String = Petfinder().token
    
    var allSheltersArray = [Shelter]()
    var dataChanged: (() -> Void)?
    
    // MARK: - TableView DataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSheltersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "shelter", for: indexPath) as! SheltersViewCell
        
        let shelter = allSheltersArray[indexPath.row]
        
        cell.name = shelter.name
        cell.city = shelter.city + insertCitySpacer(shelter: shelter) + shelter.state + ", " + shelter.zip
        
        return cell
    }
    
    // MARK: - Public Functions
    
    func fetch(_ urlString: String, zipCode zip: String) {
        findShelters(url: urlString, zip: zip)
    }
    
    // MARK: - Private Helper Functions
    
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
    
    fileprivate func updateSheltersData(json: JSON) {
        
        if let shelters = json.dictionaryValue["petfinder"]?["shelters"]["shelter"] {
            
            for (_, shelter) in shelters {
                print("shelter \(shelter)")
                let currentShelter = Shelter(json: shelter)
                self.allSheltersArray.append(currentShelter)
            }
        }
        
        self.dataChanged?()
    }

    
    fileprivate func insertCitySpacer(shelter: Shelter) -> String {
        if shelter.city.last == " " {
            return ""
        }
        return " "
    }
}
