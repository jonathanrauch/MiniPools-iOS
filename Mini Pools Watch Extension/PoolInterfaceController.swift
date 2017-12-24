//
//  PoolInterfaceController.swift
//  Mini Pools Watch Extension
//
//  Created by Kaplún, Sebi on 12/24/17.
//  Copyright © 2017 Kaplún, Sebi. All rights reserved.
//

import WatchKit

class PoolInterfaceController: WKInterfaceController {

    @IBOutlet var poolTitle: WKInterfaceLabel!
    @IBOutlet var tableView: WKInterfaceTable!
    @IBOutlet var createdByLabel: WKInterfaceLabel!
    var pool : PoolModel?
    var users : [PersonModel] = []
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        if let pool = context as? PoolModel {
            self.pool = pool
            poolTitle.setText(pool.name)
            var createdBy = "Pool created on \(pool.createdAt.shortDate())"
            if let creator = pool.creator {
                createdBy = "\(createdBy) by \(creator.name)"
            }
            createdByLabel.setText(createdBy)
            
            refreshTable()
        }
    }
    
    func refreshTable() {
        if let pool = pool {
            self.tableView.setNumberOfRows(pool.contributions.count, withRowType: "PoolRow")
            
            for (index, contribution) in pool.contributions.enumerated() {
                let row = self.tableView.rowController(at: index) as! PoolRowController
                row.contribution = contribution
            }
        }
    }
    
    override func didAppear() {
        UsersWorker.fetchUsers{ allUsers in
            self.users = allUsers
            print("finished loading users")
        }
    }
    
    
    @IBAction func addContributionPressed() {
        if let pool = pool {
            let context = AddContributionContext()
            context.delegate = self
            context.pool = pool
            context.users = users
            pushController(withName: "AddContribution", context: context)
        }
    }
    
}

extension PoolInterfaceController : AddContributionDelegate {
    func addContribution(poolId: Int, contributor: PersonModel, note: String?, amount: Int) {
        PoolsWorker.contributeToPool(poolId: poolId, amountValue: amount, amountCurrency: "USD", note: note ?? "", contributor: contributor) { (contributor) in
            self.pool!.contributions.append(contributor)
            self.refreshTable()
        }
    }
}
