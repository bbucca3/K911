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
    let name: String
    
    init(json: JSON) {
        self.name = json["placeholder"].stringValue
    }
}
