//
//  HomePresenter.swift
//  mini-pools-ios
//
//  Created by Davidson, Shay on 31/01/2019.
//  Copyright © 2019 Kaplún, Sebi. All rights reserved.
//

import UIKit

class HomePresenter: NSObject, TableViewPresenter {
  
  enum HomeTableViewSection: Int, CaseIterable {
    case create = 0
    case pools = 1
  }

  unowned let view: TableView
  var model: HomeModel
  var previousModel: HomeModel?
  let router: UINavigationController
  
  required init(view: TableView, model: HomeModel, router: UINavigationController) {
    self.view = view
    self.model = model
    self.router = router
    super.init()
  }
  
  // MARK - API
  
  func setup() {
    self.view.setTitle("Mini-Pools")
    self.view.setSearchText(self.model.filter)
  }
  
  func loadData() {
    self.view.toggleSpinner(value: true)
    API.fetchPools { [unowned self] pools in
      self.previousModel = self.model
      self.model = HomeModel(pools: pools, filter: self.model.filter)
      self.view.refreshTable()
      self.view.toggleSpinner(value: false)
    }
  }
  
  func changedTableFilter(_ filter: String) {
    self.model.setFilter(filter)
    self.view.refreshTable()
  }
  
  func selectedTableItem(at indexPath: IndexPath) {
    switch HomeTableViewSection(rawValue: indexPath.section) {
    case .create?:
      let view = FormViewController()
      let presenter = CreatePoolPresenter(view: view, router: self.router)
      view.presenter = presenter
      self.router.pushViewController(view, animated: true)
    case .pools?:
      let model = self.model.pools[indexPath.item]
      let view = DetailsViewController()
      let presenter = PoolPresenter(view: view, model: model, router: self.router)
      view.presenter = presenter
      self.router.pushViewController(view, animated: true)
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
    case .create?: return 1
    case .pools?:  return self.model.filteredPools.count
    case .none:    return 0
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = SimpleTableViewCell()
    switch HomeTableViewSection(rawValue: indexPath.section) {
    case .create?:
      cell.setTitle("+ Create a new pool")
    case .pools?:
      let pool = self.model.filteredPools[indexPath.item]
      cell.setTitle(pool.name!)
      cell.setSubtitle(pool.formattedAmount)
    case .none: break
    }
    return cell
  }
}
