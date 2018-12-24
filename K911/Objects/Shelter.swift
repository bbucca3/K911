//
//  Shelter.swift
//  K911
//
//  Created by Benjamin Bucca on 12/16/18.
//  Copyright © 2018 Benjamin Bucca. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Shelter {
    let name: String?
    let id: String?
    let email: String?
    let phone: String?
    let city: String?
    let country: String?
    let state: String?
    let address: String?
    
    init(json: JSON) {
        self.name = json["name"]["$t"].stringValue
        self.id = json["id"]["$t"].stringValue
        self.email = json["email"]["$t"].stringValue
        self.phone = json["phone"]["$t"].stringValue
        self.city = json["city"]["$t"].stringValue
        self.country = json["country"]["$t"].stringValue
        self.state = json["state"]["$t"].stringValue
        self.address = json["address1"]["$t"].stringValue
    }
}
