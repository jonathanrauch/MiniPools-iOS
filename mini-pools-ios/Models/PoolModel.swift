//
//  PoolModel.swift
//  mini-pools-ios
//
//  Created by Kaplún, Sebi on 12/20/17.
//  Copyright © 2017 Kaplún, Sebi. All rights reserved.
//

import UIKit
import SwiftyJSON

struct PoolModel {
    var id: Int
    var name: String
    var goalAmountValue: Int
    var goalAmountCurrency: String
    var extra: String?
    var createdAt: Date
    var updatedAt: Date
    var creator: PersonModel?
    var contributions : [ContributionModel] = []
    
    init(dictionary : JSON ) {
        self.id = dictionary["id"].intValue
        self.name = dictionary["name"].stringValue
        self.goalAmountValue = dictionary["goalAmountValue"].intValue
        self.goalAmountCurrency = dictionary["goalAmountCurrency"].stringValue
        self.extra = dictionary["extra"].string
        self.createdAt = DateUtil.initDate(string: dictionary["createdAt"].stringValue)!
        self.updatedAt = DateUtil.initDate(string: dictionary["updatedAt"].stringValue)!
        
        if dictionary["creator"] != JSON.null {
            self.creator = PersonModel(dictionary: dictionary["creator"])
        }
        
        for contributionJson in dictionary["contributions"].arrayValue {
            let contribution = ContributionModel(dictionary: contributionJson)
            contributions.append(contribution)
        }
    }
}
