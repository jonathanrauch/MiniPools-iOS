//
//  HttpUtils.swift
//  mini-pools-ios
//
//  Created by Kaplún, Sebi on 12/21/17.
//  Copyright © 2017 Kaplún, Sebi. All rights reserved.
//

struct API {
    static let baseServerUrl = "https://mini-pools.herokuapp.com"
    static let allUsers = "/users"
    static let allPools = "/pools"
    static let contributions = "/contributions"
    
    struct Parameters {
        static let amountValue = "amountValue"
        static let amountCurrency = "amountCurrency"
        static let note = "note"
        static let contributorId = "contributorId"
    }
}
