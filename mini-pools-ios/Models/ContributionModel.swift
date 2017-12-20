//
//  ContributionModel.swift
//  mini-pools-ios
//
//  Created by Kaplún, Sebi on 12/20/17.
//  Copyright © 2017 Kaplún, Sebi. All rights reserved.
//

import UIKit
import SwiftyJSON

struct ContributionModel {
    var id: Int
    var amountValue: Int
    var amountCurrency: String
    var note: String?
    var extra: String?
    var createdAt: Date
    var updatedAt: Date
    var contributor : PersonModel
    
    init(dictionary : JSON ) {
        self.id = dictionary["id"].intValue
        self.amountValue = dictionary["amountValue"].intValue
        self.amountCurrency = dictionary["amountCurrency"].stringValue
        self.note = dictionary["note"].string
        self.extra = dictionary["extra"].string
        self.createdAt = DateUtil.initDate(string: dictionary["createdAt"].stringValue)!
        self.updatedAt = DateUtil.initDate(string: dictionary["updatedAt"].stringValue)!
        self.contributor = PersonModel(dictionary:dictionary["contributor"])
    }
}

