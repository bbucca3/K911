//
//  PetsViewController.swift
//  K911
//
//  Created by Benjamin Bucca on 1/1/19.
//  Copyright © 2019 Benjamin Bucca. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PetsViewController: UITableViewController {

    // MARK: - Properties
    
    let PETS_URL: String = "http://api.petfinder.com/shelter.getPets"
    let API_KEY: String = Petfinder().token
    var allPetsArray = [Pet]()
    var shelterId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("shelterId is \(shelterId ?? "")")
        if let shelterId = shelterId {
            findPets(url: PETS_URL, id: shelterId)
        }
    }

    // MARK: - TableView DataSource Methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPetsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pet", for: indexPath)

        let item = allPetsArray[indexPath.row]
        
        cell.textLabel?.text = item.name

        return cell
    }
    
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Networking Functions
    
    fileprivate func findPets(url: String, id: String) {
        
        let params: [String : Any] = ["key" : API_KEY, "id" : id, "format" : "json", "count" : 50]
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON {
            response in
            if response.result.isSuccess {
                if let value = response.result.value {
                    let petsJSON: JSON = JSON(value)
                    self.updatePetsData(json: petsJSON)
                }
            } else {
                print("findPets Error \(String(describing: response.result.error))")
            }
        }
    }
    
    // MARK: - JSON Parsing
    
    fileprivate func updatePetsData(json: JSON) {
        
        if let pets = json.dictionaryValue["petfinder"]?["pets"]["pet"] {
//            print("pets: ", pets.type)
            if pets.type == .dictionary {
                
                var singlePet = Pet(json: pets)
                
                if let photos = pets.dictionaryValue["media"]?["photos"]["photo"] {
                    for (_, photo) in photos {
                        let petPhoto = Photo(json: photo)
                        print(petPhoto)
                        singlePet.photos.append(petPhoto)
                    }
                }
                
                self.allPetsArray.append(singlePet)
                
            } else {
                
                for (_, pet) in pets {
                    var currentPet = Pet(json: pet)
                    
                    if let photos = pet.dictionaryValue["media"]?["photos"]["photo"] {
                        for (_, photo) in photos {
                            let petPhoto = Photo(json: photo)
                            print(petPhoto)
                            currentPet.photos.append(petPhoto)
                        }
                    }
                    
                    self.allPetsArray.append(currentPet)
                }
            }
        }
        
        tableView.reloadData()
    }

}
