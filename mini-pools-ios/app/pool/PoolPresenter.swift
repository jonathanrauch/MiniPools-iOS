//
//  PoolPresenter.swift
//  mini-pools-ios
//
//  Created by Davidson, Shay on 31/01/2019.
//  Copyright © 2019 Kaplún, Sebi. All rights reserved.
//

import UIKit

protocol PoolView: class {
  func toggleSpinner(value: Bool)
  func toggleInteraction(value: Bool)
  func setTitle(title: String)
  func setName(name: String)
  func setAmount(amount: String)
  func navigateToEditPoolPage()
  func navigateToHomePage()
}

class PoolPresenter {
  unowned let view: PoolView
  var model: PoolModel
  
  required init(view: PoolView, model: PoolModel) {
    self.view = view
    self.model = model
  }
  
  // MARK - API
  
  func renderPool() {
    self.view.setTitle(title: self.model.name)
    self.view.setName(name: self.model.name)
    self.view.setAmount(amount: self.model.formattedAmount)
  }
  
  func selectedDelete() {
    self.view.toggleSpinner(value: true)
    self.view.toggleInteraction(value: false)
    API.deletePool(poolId: self.model.id) { [unowned self] in
      self.view.toggleSpinner(value: false)
      self.view.toggleInteraction(value: true)
      self.view.navigateToHomePage()
    }
  }
  
  func selectedEdit() {
    self.view.navigateToEditPoolPage()
  }
  
}
