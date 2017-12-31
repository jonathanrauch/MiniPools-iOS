//
//  AddContributionProtocols.swift
//  mini-pools-ios
//
//  Created by Kaplún, Sebi on 12/21/17.
//  Copyright © 2017 Kaplún, Sebi. All rights reserved.
//

protocol AddContributionDelegate: class {
    func addContribution(poolId: Int, contributor : PersonModel, note: String?, amount: Int)
}
