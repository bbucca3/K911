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
    
    let API_KEY: String = Petfinder().token
    let PETS_URL: String = "http://api.petfinder.com/shelter.getPets"
    let PET_DETAIL: String = "petDetail"
    var allPetsArray = [Pet]()
    var shelterId: String?
    var selectedPet: Pet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pet", for: indexPath) as! PetViewCell

        let pet = allPetsArray[indexPath.row]
        
        if let url = URL(string: (pet.photos.first?.url ?? "")) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    cell.img = UIImage(data: data!)
                }
            }

        }
        
        let sexOfPet = pet.sex == "M" ? "Male" : "Female"
        cell.name = NSLocalizedString("Name: \(pet.name)", comment: "PET_NAME_\(pet.name)")
        cell.animal = NSLocalizedString("\(sexOfPet) \(pet.animal)", comment: "ANIMAL_\(sexOfPet)_\(pet.animal)")
        cell.age = NSLocalizedString("Age: \(pet.age)", comment: "PET_AGE_\(pet.age)")

        return cell
    }
    
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let pet = allPetsArray[indexPath.row]
        selectedPet = pet
        performSegue(withIdentifier: PET_DETAIL, sender: self)
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
            
            if pets.type == .dictionary {
                
                let singlePet = Pet(json: pets)
                parsePhotosForPet(pet: singlePet, json: pets)
            } else {
                
                for (_, pet) in pets {
                    
                    let currentPet = Pet(json: pet)
                    parsePhotosForPet(pet: currentPet, json: pet)
                }
            }
        }
        
        tableView.reloadData()
    }
    
    fileprivate func parsePhotosForPet(pet: Pet, json: JSON) {
        
        var shelterPet = pet
        
        if let photos = json.dictionaryValue["media"]?["photos"]["photo"] {
            for (_, photo) in photos {
                if (photo["@size"] == "x") {
                    let petPhoto = Photo(json: photo)
                    shelterPet.photos.append(petPhoto)
                }
            }
        }
        
        self.allPetsArray.append(shelterPet)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == PET_DETAIL {
            let petDetailVC = segue.destination as! PetDetailViewController
            if let selectedPet = selectedPet {
                petDetailVC.pet = selectedPet
            }
        }
    }

}
