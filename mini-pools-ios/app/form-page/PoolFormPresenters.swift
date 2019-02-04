//
//  PoolFormPresenters.swift
//  mini-pools-ios
//
//  Created by Davidson, Shay on 31/01/2019.
//  Copyright © 2019 Kaplún, Sebi. All rights reserved.
//

import UIKit

class PoolFormPresenter: NSObject, FormViewPresenter {
  
  enum Fields: Int, CaseIterable {
    case name = 0
    case goal = 1
    
    var isRequired: Bool {
      switch self {
      case .name: return true
      case .goal: return false
      }
    }
    
    var title: String {
      switch self {
      case .name: return "Name"
      case .goal: return "Goal Amount"
      }
    }
  }
  
  unowned let view: FormView
  var model: AbstractPoolModel?
  let router: UINavigationController
  
  init(view: FormView, model: AbstractPoolModel? = nil, router: UINavigationController) {
    self.view = view
    self.model = model
    self.router = router
    super.init()
  }
  
  func setup() {
    self.view.addField(label: Fields.name.title, placeholder: Fields.name.isRequired ? "required" : "optional", prefilledValue: self.model?.name)
    self.view.addField(label: Fields.goal.title, placeholder: Fields.goal.isRequired ? "required" : "optional", prefilledValue: self.model?.goalAmountValue != nil ? "\(self.model!.goalAmountValue!)" : nil)
  }
  
  func changedFieldValue(at index: Int, value: String) {
    switch (index) {
    case Fields.name.rawValue: self.model!.name = value
    case Fields.goal.rawValue: self.model!.goalAmountValue = Int(value)
    default: break
    }
  }
  
  func selectedAction() {
    fatalError("needs to be overriden")
  }
}

// MARK - Create

class CreatePoolPresenter: PoolFormPresenter {
  required init(view: FormView, router: UINavigationController) {
    super.init(view: view, model: NewPoolModel(), router: router)
  }
  
  override func setup() {
    super.setup()
    self.view.setTitle("Create a pool")
    self.view.setActionTitle("Create")
  }
  
  override func selectedAction() {
    self.view.toggleSpinner(value: true)
    self.view.toggleInteraction(value: false)
    let model = self.model as! NewPoolModel
    API.createPool(poolName: model.name!, goalAmountValue: model.goalAmountValue, completion: { [unowned self] pool in
      self.view.toggleSpinner(value: false)
      self.view.toggleInteraction(value: true)
      self.router.popViewController(animated: true)
    })
  }
}

// MARK - Edit

class EditPoolPresenter: PoolFormPresenter {
  required init(view: FormView, model: PoolModel, router: UINavigationController) {
    super.init(view: view, model: model, router: router)
  }
  
  override func setup() {
    super.setup()
    self.view.setTitle(self.model!.name!)
    self.view.setActionTitle("Save")
  }
  
  override func selectedAction() {
    self.view.toggleSpinner(value: true)
    self.view.toggleInteraction(value: false)
    let model = self.model as! PoolModel
    API.updatePool(poolId: model.id!, poolName: model.name!, goalAmountValue: model.goalAmountValue, completion: { [unowned self] pool in
      self.view.toggleSpinner(value: false)
      self.view.toggleInteraction(value: true)
      self.router.popViewController(animated: true)
    })
  }
}

