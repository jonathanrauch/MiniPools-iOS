//
//  PoolsWorker.swift
//  mini-pools-ios
//
//  Created by Kaplún, Sebi on 12/20/17.
//  Copyright © 2017 Kaplún, Sebi. All rights reserved.
//

import Alamofire
import SwiftyJSON

class PoolsWorker {
    
    static func fetchPools(completion: @escaping ([PoolModel]) -> Void) {
        Alamofire.request("\(API.baseServerUrl)\(API.allPools)").responseJSON { response in
            var pools : [PoolModel] = []
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
        let parameters: Parameters = [API.Parameters.amountValue: amountValue, API.Parameters.amountCurrency: amountCurrency, API.Parameters.note: note ?? "",  API.Parameters.contributorId: contributor.id]
        Alamofire.request("\(API.baseServerUrl)\(API.allPools)/\(poolId)\(API.contributions)", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            if let responseResult = response.result.value {
                let json = JSON(responseResult)
                let contribution = ContributionModel(dictionary: json, contributor: contributor)
                completion(contribution)
            }
        }
    }
}
