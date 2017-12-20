//
//  ContributionModel.swift
//  mini-pools-ios
//
//  Created by Kaplún, Sebi on 12/20/17.
//  Copyright © 2017 Kaplún, Sebi. All rights reserved.
//

import UIKit

struct ContributionModel {
    var id: Int
    var amountValue: Int
    var amountCurrency: String
    var note: String?
    var extra: String?
    var createdAt: Date
    var updatedAt: Date
    var contributor : PersonModel
}


