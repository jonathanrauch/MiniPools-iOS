//
//  API.swift
//  mini-pools-ios
//
//  Created by Davidson, Shay on 10/01/2019.
//  Copyright © 2019 Kaplún, Sebi. All rights reserved.
//

import Alamofire
import SwiftyJSON

class API {
  
  // MARK: consts
  
  private static let baseServerUrl = "https://mini-pools.herokuapp.com"
  private static let usersPath = "/users"
  private static let poolsPath = "/pools"
  private static let contributionsPath = "/contributions"
  
  private static let amountValueParam = "amountValue"
  private static let amountCurrencyParam = "amountCurrency"
  private static let noteParam = "note"
  private static let contributorIdParam = "contributorId"
  
  // MARK: endpoints
  
  static func fetchUsers(completion: @escaping ([PersonModel]) -> Void) {
    Alamofire.request("\(API.baseServerUrl)\(API.usersPath)").responseJSON { response in
      var users : [PersonModel] = []
      if let responseResult = response.result.value {
        let json = JSON(responseResult)
        for userJson in json.arrayValue {
          let user = PersonModel(dictionary: userJson)
          users.append(user)
        }
      }
      completion(users)
    }
  }
  
  static func fetchPools(completion: @escaping ([PoolModel]) -> Void) {
    Alamofire.request("\(API.baseServerUrl)\(API.poolsPath)").responseJSON { response in
      var pools: [PoolModel] = []
      if let responseResult = response.result.value {
        let json = JSON(responseResult)
        for poolJson in json.arrayValue {
          let pool = PoolModel(dictionary: poolJson)
          pools.append(pool)
        }
      }
      completion(pools)
    }
  }
  
  static func contributeToPool(poolId: Int, amountValue: Int, amountCurrency: String, note: String?, contributor: PersonModel, completion: @escaping (ContributionModel) -> Void) {
    let parameters: Parameters = [
      API.amountValueParam: amountValue,
      API.amountCurrencyParam: amountCurrency,
      API.noteParam: note ?? "",
      API.contributorIdParam: contributor.id
    ]
    
    Alamofire.request("\(API.baseServerUrl)\(API.poolsPath)/\(poolId)\(API.contributionsPath)", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
      if let responseResult = response.result.value {
        let json = JSON(responseResult)
        let contribution = ContributionModel(dictionary: json, contributor: contributor)
        completion(contribution)
      }
    }
  }
}
