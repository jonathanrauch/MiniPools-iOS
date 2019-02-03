//
//  HomeDataSource.swift
//  mini-pools-ios
//
//  Created by Davidson, Shay on 31/01/2019.
//  Copyright © 2019 Kaplún, Sebi. All rights reserved.
//

import UIKit

enum HomeTableViewSection: Int, CaseIterable {
  case action = 0
  case pools = 1
}

class HomeDataSource: NSObject, UITableViewDataSource {
  
  let model: HomeModel
  let stringFilter: String?
  
  required init(model: HomeModel, stringFilter: String? = nil) {
    self.model = model
    self.stringFilter = (stringFilter?.isEmpty ?? true) ? nil : stringFilter
  }
  
  // MARK - Filter
  
  var filteredPools: [PoolModel] {
    if let stringFilter = self.stringFilter {
      return model.pools.filter { $0.name.lowercased().contains(stringFilter.lowercased()) }
    } else {
      return model.pools
    }
  }
  
  // MARK - UITableViewDataSource
  
   func numberOfSections(in tableView: UITableView) -> Int {
    return HomeTableViewSection.allCases.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch HomeTableViewSection(rawValue: section) {
    case .action?: return 1
    case .pools?:  return self.filteredPools.count
    case .none:    return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
    switch HomeTableViewSection(rawValue: indexPath.section) {
    case .action?:
      cell.textLabel?.text = "+ Create a new pool"
    case .pools?:
      let pool = self.filteredPools[indexPath.item]
      cell.textLabel?.text = pool.name
      cell.detailTextLabel?.text = pool.hasGoal ? "$\(pool.contributionsSum) / $\(pool.goalAmountValue!)" : "$\(pool.contributionsSum)"
    case .none: break
    }
    return cell
  }
}
