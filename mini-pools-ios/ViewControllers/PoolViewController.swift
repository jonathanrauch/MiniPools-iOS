//
//  PoolViewController.swift
//  mini-pools-ios
//
//  Created by Kaplún, Sebi on 12/20/17.
//  Copyright © 2017 Kaplún, Sebi. All rights reserved.
//

import UIKit

class PoolViewController: UIViewController {

    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var contributionsTableView: UITableView!
    
    var pool : PoolModel?
    var users : [PersonModel] = []
    var isSyncingContribution = false

    override func viewDidLoad() {
        super.viewDidLoad()

        contributionsTableView.dataSource = self
        contributionsTableView.delegate = self
        contributionsTableView.tableFooterView = UIView()

        if let pool = pool {
            self.title = pool.name
            createdLabel.text = "Pool created on \(pool.createdAt.shortDate())"
            if let creator = pool.creator {
                createdLabel.text = "\(createdLabel.text!) by \(creator.name)"
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UsersWorker.fetchUsers{ allUsers in
            self.users = allUsers
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddContributionViewController
        vc.users = users
        vc.poolId = pool!.id
        vc.delegate = self
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext //All objects and view are transparent
    }

}

extension PoolViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let pool = pool {
            return  pool.contributions.count  + (isSyncingContribution ? 1 : 0)
        }
        return isSyncingContribution ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row  < pool!.contributions.count {
            var cell = contributionsTableView.dequeueReusableCell(withIdentifier: "ContributionCell", for: indexPath) as! ContributionCellTableViewCell
            cell.contributorLabel.text = "\(pool!.contributions[indexPath.row].contributor.name)"
            cell.amountLabel.text = "\(pool!.contributions[indexPath.row].amountCurrency.getSymbolForCurrencyCode())\(pool!.contributions[indexPath.row].amountValue)"
            cell.noteLabel.text = "\(pool!.contributions[indexPath.row].note ?? "")"
            
            cell = removeMagins(cell) as! ContributionCellTableViewCell
            return cell
        } else {
            var cell = contributionsTableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath)
            cell = removeMagins(cell)
            return cell
        }
    }
    
    func removeMagins(_ cell: UITableViewCell) -> UITableViewCell {
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero

        return cell
    }
}

extension PoolViewController : UITableViewDelegate {

}

extension PoolViewController : AddContributionDelegate {
    func addContribution(poolId: Int, contributor: PersonModel, note: String?, amount: Int) {
        isSyncingContribution = true

        contributionsTableView.beginUpdates()
        contributionsTableView.insertRows(at: [IndexPath(row: pool!.contributions.count, section: 0)], with: .automatic)
        contributionsTableView.endUpdates()
        
        
        PoolsWorker.contributeToPool(poolId: poolId, amountValue: amount, amountCurrency: "USD", note: note, contributor: contributor) { (contributor) in
            self.pool!.contributions.append(contributor)
            self.isSyncingContribution = false
            
            let indexPath = IndexPath(item: self.pool!.contributions.count - 1, section: 0)
            self.contributionsTableView.reloadRows(at: [indexPath], with: .top)
        }
    }
}
