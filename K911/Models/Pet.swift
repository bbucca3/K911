//
//  Pet.swift
//  K911
//
//  Created by Benjamin Bucca on 1/1/19.
//  Copyright © 2019 Benjamin Bucca. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Pet {
    let name: String
    let age: String
    let sex: String
    let animal: String
    let size: String
    let photos: Array<Any>
    
    init(json: JSON) {
        self.name = json["name"]["$t"].stringValue
        self.age = json["age"]["$t"].stringValue
        self.sex = json["sex"]["$t"].stringValue
        self.animal = json["animal"]["$t"].stringValue
        self.size = json["size"]["$t"].stringValue
        self.photos = json["media"]["photos"]["photo"].arrayValue
    }
}
