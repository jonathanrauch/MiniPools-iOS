//
//  UsersWorker.swift
//  mini-pools-ios
//
//  Created by Kaplún, Sebi on 12/21/17.
//  Copyright © 2017 Kaplún, Sebi. All rights reserved.
//

import Alamofire
import SwiftyJSON

class UsersWorker {
    
    static func fetchUsers(completion: @escaping ([PersonModel]) -> Void) {
        Alamofire.request("\(API.BaseServerUrl)\(API.AllUsers)").responseJSON { response in
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
}

