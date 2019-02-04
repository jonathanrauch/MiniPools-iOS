//
//  HomePresenter.swift
//  mini-pools-ios
//
//  Created by Davidson, Shay on 31/01/2019.
//  Copyright © 2019 Kaplún, Sebi. All rights reserved.
//

import UIKit

protocol HomeView: class {
  func setTitle(_ title: String)
  func toggleSpinner(value: Bool)
  func refreshTable()
}

class HomePresenter: NSObject, TableViewPresenter {
  
  enum HomeTableViewSection: Int, CaseIterable {
    case action = 0
    case pools = 1
  }

  unowned let view: HomeView
  var model: HomeModel
  let router: UINavigationController
  
  required init(view: HomeView, model: HomeModel, router: UINavigationController) {
    self.view = view
    self.model = model
    self.router = router
    super.init()
    self.setupView()
  }
  
  private func setupView() {
    self.view.setTitle("Mini-Pools")
  }
  
  // MARK - API
  
  func loadData() {
    self.view.toggleSpinner(value: true)
    API.fetchPools { [unowned self] pools in
      self.model.pools = pools // TODO: immutable?
      self.view.refreshTable()
      self.view.toggleSpinner(value: false)
    }
  }
  
  func setTableFilter(_ filter: String) {
    self.model.setFilter(filter)
  }
  
  func selectedTableItem(at indexPath: IndexPath) {
    switch HomeTableViewSection(rawValue: indexPath.section) {
    case .action?:
      self.router.pushViewController(PoolFormViewController(), animated: true)
    case .pools?:
      let pool = self.model.pools[indexPath.item]
      self.router.pushViewController(PoolViewController(model: pool), animated: true)
    case .none:
      break
    }
  }
  
  // MARK - UITableViewDataSource
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return HomeTableViewSection.allCases.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch HomeTableViewSection(rawValue: section) {
    case .action?: return 1
    case .pools?:  return self.model.filteredPools.count
    case .none:    return 0
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
    switch HomeTableViewSection(rawValue: indexPath.section) {
    case .action?:
      cell.textLabel?.text = "+ Create a new pool"
    case .pools?:
      let pool = self.model.filteredPools[indexPath.item]
      cell.textLabel?.text = pool.name
      cell.detailTextLabel?.text = pool.formattedAmount
    case .none: break
    }
    return cell
  }
}
