//
//  Models.swift
//  mini-pools-ios
//
//  Created by Davidson, Shay on 10/01/2019.
//  Copyright © 2019 Kaplún, Sebi. All rights reserved.
//

import SwiftyJSON

// MARK - PoolModel

protocol AbstractPoolModel {
  var id: Int? { get set }
  var name: String? { get set }
  var goalAmountValue: Int? { get set }
  var contributionsSum: Int { get }
}

struct NewPoolModel: AbstractPoolModel {
  var id: Int?
  var name: String?
  var goalAmountValue: Int?
  var contributionsSum: Int {
    return 0
  }
}

struct PoolModel: AbstractPoolModel {
  var id: Int?
  var name: String?
  var goalAmountValue: Int?
  var goalAmountCurrency: String?
  var createdAt: Date
  var updatedAt: Date
  var contributions: [ContributionModel] = []
  
  init(dictionary: JSON) {
    self.id = dictionary["id"].intValue
    self.name = dictionary["name"].stringValue
    self.goalAmountValue = dictionary["goalAmountValue"].int
    self.goalAmountCurrency = dictionary["goalAmountCurrency"].string
    self.createdAt = DateUtil.initDate(string: dictionary["createdAt"].stringValue)!
    self.updatedAt = DateUtil.initDate(string: dictionary["updatedAt"].stringValue)!
    
    for contributionJson in dictionary["contributions"].arrayValue {
      let contribution = ContributionModel(dictionary: contributionJson)
      contributions.append(contribution)
    }
  }
}

extension PoolModel {
  var hasGoal: Bool {
    return self.goalAmountValue != nil
  }
  
  var contributionsSum: Int {
    return self.contributions.reduce(0) { (sum, contribution) -> Int in
      return sum + contribution.amountValue
    }
  }
  
  var formattedAmount: String {
    return self.hasGoal ? "$\(self.contributionsSum) / $\(self.goalAmountValue!)" : "$\(self.contributionsSum)"
  }
}

// MARK - ContributionModel

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

