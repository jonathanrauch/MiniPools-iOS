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
    
    static let BASE_SERVER = "https://mini-pools.herokuapp.com"
    static let FETCH_POOLS_URL = "/pools"

    static func fetchPools(completion: @escaping ([PoolModel]) -> Void) {
        Alamofire.request("\(BASE_SERVER)\(FETCH_POOLS_URL)").responseJSON { response in
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
