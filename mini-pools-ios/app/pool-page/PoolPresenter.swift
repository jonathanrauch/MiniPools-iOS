//
//  PoolPresenter.swift
//  mini-pools-ios
//
//  Created by Davidson, Shay on 31/01/2019.
//  Copyright © 2019 Kaplún, Sebi. All rights reserved.
//

import UIKit

class PoolPresenter: NSObject, DetailsViewPresenter {
  unowned let view: DetailsView
  var model: PoolModel
  let router: UINavigationController
  
  required init(view: DetailsView, model: PoolModel, router: UINavigationController) {
    self.view = view
    self.model = model
    self.router = router
    super.init()
  }
  
  // MARK - API
  
  func setup() {
    self.view.setTitle(self.model.name)
    self.view.addDetail(text: self.model.name, size: .big)
    self.view.addDetail(text: self.model.formattedAmount, size: .small)
  }
  
  // MARK - API
//
//  func renderPool() {
//    self.view.setTitle(self.model.name)
//    self.view.setName(name: self.model.name)
//    self.view.setAmount(amount: self.model.formattedAmount)
//  }
//
//  func selectedDelete() {
//    self.view.toggleSpinner(value: true)
//    self.view.toggleInteraction(value: false)
//    API.deletePool(poolId: self.model.id) { [unowned self] in
//      self.view.toggleSpinner(value: false)
//      self.view.toggleInteraction(value: true)
//      self.view.navigateToHomePage()
//    }
//  }
//
//  func selectedEdit() {
//    self.view.navigateToEditPoolPage()
//  }
  
}

//
//func navigateToEditPoolPage() {
//  self.navigationController?.pushViewController(PoolFormViewController(model: self.model), animated: true)
//}
//
//func navigateToHomePage() {
//  self.navigationController?.popViewController(animated: true)
//}
