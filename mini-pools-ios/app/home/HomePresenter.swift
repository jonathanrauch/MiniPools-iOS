//
//  HomePresenter.swift
//  mini-pools-ios
//
//  Created by Davidson, Shay on 31/01/2019.
//  Copyright © 2019 Kaplún, Sebi. All rights reserved.
//

import UIKit

protocol HomeView: class {
  func toggleSpinner(value: Bool)
  func setDataSource(_ dataSource: HomeDataSource)
  func navigateToCreatePoolPage()
  func navigateToPoolPage(_ pool: PoolModel)
}

class HomePresenter {
  unowned let view: HomeView
  var model: HomeModel
  
  required init(view: HomeView, model: HomeModel) {
    self.view = view
    self.model = model
  }
  
  // MARK - API
  
  func loadPools() {
    self.view.toggleSpinner(value: true)
    API.fetchPools { [unowned self] pools in
      self.model.pools = pools // TODO: immutable?
      self.view.setDataSource(HomeDataSource(model: self.model))
      self.view.toggleSpinner(value: false)
    }
  }
  
  func filterPools(stringFilter: String) {
    self.view.setDataSource(HomeDataSource(model: self.model, stringFilter: stringFilter))
  }
  
  func selectedItem(at: IndexPath) {
    switch HomeTableViewSection(rawValue: at.section) {
    case .action?:
      self.view.navigateToCreatePoolPage()
    case .pools?:
      self.view.navigateToPoolPage(self.model.pools[at.item])
    case .none:
      break
    }
  }
}
