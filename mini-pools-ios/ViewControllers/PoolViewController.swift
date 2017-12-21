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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddContributionViewController
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext //All objects and view are transparent
    }

}

extension PoolViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pool?.contributions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contributionsTableView.dequeueReusableCell(withIdentifier: "ContributionCell", for: indexPath) as! ContributionCellTableViewCell
        
        cell.contributorLabel.text = "\(pool!.contributions[indexPath.row].contributor.name)"
        cell.amountLabel.text = "\(pool!.contributions[indexPath.row].amountCurrency.getSymbolForCurrencyCode())\(pool!.contributions[indexPath.row].amountValue)"
        cell.noteLabel.text = "\(pool!.contributions[indexPath.row].note ?? "")"
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }
}

extension PoolViewController : UITableViewDelegate {

}
