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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        findShelters(url: SHELTER_URL, zip: zipCode ?? "")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Alamofire Networking
    fileprivate func findShelters(url: String, zip: String) {
        let params: [String:Any] = ["key" : API_KEY, "location" : zip, "format" : "json", "offset" : 0]
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success \(response.result.value ?? "")")
            }
            else {
                print("Error \(String(describing: response.result.error))")
            }
        }
    }

}
