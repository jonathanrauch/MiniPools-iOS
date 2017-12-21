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
        Alamofire.request("\(API.BaseServerUrl)\(API.AllPools)").responseJSON { response in
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
}
