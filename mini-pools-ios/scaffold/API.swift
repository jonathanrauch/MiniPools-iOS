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
  
  private static let nameParam = "name"
  private static let amountValueParam = "goalAmountValue"
  private static let creatorIdParam = "creatorId"
  private static let amountCurrencyParam = "goalAmountCurrency"
  private static let contributorIdParam = "contributorId"
  
  // MARK: endpoints

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
  
  static func createPool(poolName: String, goalAmountValue: Int? = nil, completion: @escaping (PoolModel) -> Void) {
    let parameters: Parameters
    if let goalAmountValue = goalAmountValue {
      parameters = [
        API.nameParam: poolName,
        API.amountValueParam: goalAmountValue,
        API.amountCurrencyParam: "USD",
        API.creatorIdParam: 6
      ]
    } else {
      parameters = [
        API.nameParam: poolName,
        API.creatorIdParam: 6
      ]
    }
  
    Alamofire.request("\(API.baseServerUrl)\(API.poolsPath)", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
      if let responseResult = response.result.value {
        let json = JSON(responseResult)
        let pool = PoolModel(dictionary: json)
        completion(pool)
      }
    }
  }
  
  static func updatePool(poolId: String, poolName: String, goalAmountValue: Int? = nil, completion: @escaping (PoolModel) -> Void) {
    let parameters: Parameters = [
      API.nameParam: poolName,
      API.amountValueParam: goalAmountValue as Any
    ]
    
    Alamofire.request("\(API.baseServerUrl)\(API.poolsPath)/\(poolId)", method: .patch, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
      if let responseResult = response.result.value {
        let json = JSON(responseResult)
        var pool = PoolModel(dictionary: json)
        // hack, server doesn't return updated item
        pool.name = poolName
        pool.goalAmountValue = goalAmountValue
        completion(pool)
      }
    }
  }
  
  static func deletePool(poolId: String, completion: @escaping () -> Void) {
    Alamofire.request("\(API.baseServerUrl)\(API.poolsPath)/\(poolId)", method: .delete, encoding: JSONEncoding.default).responseJSON { response in
        completion()
      }
  }
}
