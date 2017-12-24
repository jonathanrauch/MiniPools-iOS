//
//  InterfaceController.swift
//  Mini Pools Watch Extension
//
//  Created by Kaplún, Sebi on 12/24/17.
//  Copyright © 2017 Kaplún, Sebi. All rights reserved.
//

import WatchKit
import Foundation
import Alamofire

class InterfaceController: WKInterfaceController {

    @IBOutlet var tableView: WKInterfaceTable!
    var allPools : [PoolModel] = []

    override func awake(withContext context: Any?) {
        
        super.awake(withContext: context)
        
        PoolsWorker.fetchPools { allPools in
            self.allPools = allPools
            self.tableView.setNumberOfRows(allPools.count, withRowType: "AllPoolsRow")
            
            for (index, pool) in allPools.enumerated() {
                let row = self.tableView.rowController(at: index) as! AllPoolsRowController
                row.poolNameLabel.setText(pool.name)
            }
            
        }
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let pool = allPools[rowIndex]
        pushController(withName: "Pool", context: pool)
    }

    
}
