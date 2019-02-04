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
    self.view.setTitle(self.model.name!)
    self.view.addDetail(text: self.model.name!, size: .big)
    self.view.addDetail(text: self.model.formattedAmount, size: .small)
    
    self.view.addButton(text: "Edit") { [unowned self] in
      let model = self.model
      let view = FormViewController()
      let presenter = EditPoolPresenter(view: view, model: model, router: self.router)
      view.presenter = presenter
      self.router.pushViewController(view, animated: true)
    }
    
    self.view.addButton(text: "Delete") { [unowned self] in
      self.view.toggleSpinner(value: true)
      self.view.toggleInteraction(value: false)
      API.deletePool(poolId: self.model.id) { [unowned self] in
        self.view.toggleSpinner(value: false)
        self.view.toggleInteraction(value: true)
        self.router.popViewController(animated: true)
      }
    }
  }
}
