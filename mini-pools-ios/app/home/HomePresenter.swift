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
  func setDataSource(_ dataSource: HomeDataSource)
  func navigateToCreatePoolPage()
  func navigateToPoolPage(_ pool: PoolModel)
}

class HomePresenter: TableViewPresenter {
  
  unowned let view: HomeView
  var model: HomeModel
  
  required init(view: HomeView, model: HomeModel) {
    self.view = view
    self.model = model
    self.setupView()
  }
  
  private func setupView() {
    self.view.setTitle("Mini-Pools")
  }
  
  // MARK - API
  
  func refreshTable() {
    self.view.toggleSpinner(value: true)
    API.fetchPools { [unowned self] pools in
      self.model.pools = pools // TODO: immutable?
      self.view.setDataSource(HomeDataSource(model: self.model))
      self.view.toggleSpinner(value: false)
    }
  }
  
  func setTableFilter(_ filter: String) {
    self.view.setDataSource(HomeDataSource(model: self.model, stringFilter: filter))
  }
  
  func selectedTableItem(at indexPath: IndexPath) {
    switch HomeTableViewSection(rawValue: indexPath.section) {
    case .action?:
      self.view.navigateToCreatePoolPage()
    case .pools?:
      self.view.navigateToPoolPage(self.model.pools[indexPath.item])
    case .none:
      break
    }
  }
}
