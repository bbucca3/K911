//
//  Photo.swift
//  K911
//
//  Created by Benjamin Bucca on 1/1/19.
//  Copyright © 2019 Benjamin Bucca. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Photo {
    let id: String
    let size: String
    let url: String
    
    init(json: JSON) {
        self.id = json["@id"].stringValue
        self.size = json["@size"].stringValue
        self.url = json["$t"].stringValue
    }
}
