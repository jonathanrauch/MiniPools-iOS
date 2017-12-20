//
//  File.swift
//  mini-pools-ios
//
//  Created by Kaplún, Sebi on 12/20/17.
//  Copyright © 2017 Kaplún, Sebi. All rights reserved.
//

import UIKit

struct AllPoolsModel {
    var id: Int
    var name: String
    var goalAmountValue: Int
    var goalAmountCurrency: String
    var extra: String?
    var createdAt: Date
    var updatedAt: Date
    var creator: PersonModel
    var contributions : [ContributionModel]
}
