//
//  PersonModel.swift
//  mini-pools-ios
//
//  Created by Kaplún, Sebi on 12/20/17.
//  Copyright © 2017 Kaplún, Sebi. All rights reserved.
//

import UIKit
import SwiftyJSON

struct PersonModel {
    var id: Int
    var name: String
    var avatarUrl: String
    var extra: String?
    var createdAt: Date
    var updatedAt: Date
    
     init(dictionary : JSON ) {
        self.id = dictionary["id"].intValue
        self.name = dictionary["name"].stringValue
        self.avatarUrl = dictionary["avatarUrl"].stringValue
        self.extra = dictionary["extra"].string
        self.createdAt = DateUtil.initDate(string: dictionary["createdAt"].stringValue)!
        self.updatedAt = DateUtil.initDate(string: dictionary["updatedAt"].stringValue)!
    }
}

