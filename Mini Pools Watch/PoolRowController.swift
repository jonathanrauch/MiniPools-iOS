//
//  PoolRowController.swift
//  Mini Pools Watch Extension
//
//  Created by Kaplún, Sebi on 12/24/17.
//  Copyright © 2017 Kaplún, Sebi. All rights reserved.
//

import WatchKit

class PoolRowController: NSObject {
    @IBOutlet var contributorName: WKInterfaceLabel!
    @IBOutlet var contributionNote: WKInterfaceLabel!
    @IBOutlet var contributionAmount: WKInterfaceLabel!
    
    var contribution : ContributionModel? {
        didSet {
            guard let contribution = contribution else { return }
            contributorName.setText(contribution.contributor.name)
            contributionNote.setText(contribution.note)
            contributionAmount.setText("\(contribution.amountCurrency.getSymbolForCurrencyCode())\(contribution.amountValue)")
        }
    }
    
}
