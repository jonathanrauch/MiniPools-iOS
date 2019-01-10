//
//  ViewController.swift
//  mini-pools-ios
//
//  Created by Kaplún, Sebi on 12/20/17.
//  Copyright © 2017 Kaplún, Sebi. All rights reserved.
//

import UIKit

class AllPoolsTableViewController: UITableViewController {
  
  @IBOutlet weak var poolsTableView: UITableView!
  
  var allPools : [PoolModel] = [] {
    didSet {
      poolsTableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.tableFooterView = UIView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    API.fetchPools { allPools in
      self.allPools = allPools
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    self.navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return allPools.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "AllPoolsCell", for: indexPath)
    
    cell.textLabel?.text = allPools[indexPath.row].name
    cell.preservesSuperviewLayoutMargins = false
    cell.separatorInset = UIEdgeInsets.zero
    cell.layoutMargins = UIEdgeInsets.zero
    
    return cell
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let cell = sender as? UITableViewCell {
      let indexPath = self.tableView.indexPath(for: cell)!
      let poolViewController = segue.destination as! PoolViewController
      poolViewController.pool = self.allPools[indexPath.row]
    }
  }
  
}

