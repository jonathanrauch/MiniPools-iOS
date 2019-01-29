//
//  Models.swift
//  mini-pools-ios
//
//  Created by Davidson, Shay on 10/01/2019.
//  Copyright © 2019 Kaplún, Sebi. All rights reserved.
//

import SwiftyJSON

struct PoolModel {
  var id: Int
  var name: String
  var goalAmountValue: Int
  var goalAmountCurrency: String
  var createdAt: Date
  var updatedAt: Date
  var contributions: [ContributionModel] = []
  
  init(dictionary: JSON) {
    self.id = dictionary["id"].intValue
    self.name = dictionary["name"].stringValue
    self.goalAmountValue = dictionary["goalAmountValue"].intValue
    self.goalAmountCurrency = dictionary["goalAmountCurrency"].stringValue
    self.createdAt = DateUtil.initDate(string: dictionary["createdAt"].stringValue)!
    self.updatedAt = DateUtil.initDate(string: dictionary["updatedAt"].stringValue)!
    
    for contributionJson in dictionary["contributions"].arrayValue {
      let contribution = ContributionModel(dictionary: contributionJson)
      contributions.append(contribution)
    }
  }
}

struct ContributionModel {
  var id: Int
  var amountValue: Int
  var amountCurrency: String
  var createdAt: Date
  var updatedAt: Date
  
  init(dictionary: JSON ) {
    self.id = dictionary["id"].intValue
    self.amountValue = dictionary["amountValue"].intValue
    self.amountCurrency = dictionary["amountCurrency"].stringValue
    self.createdAt = DateUtil.initDate(string: dictionary["createdAt"].stringValue)!
    self.updatedAt = DateUtil.initDate(string: dictionary["updatedAt"].stringValue)!
  }
}

