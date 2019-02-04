//
//  PoolFormPresenters.swift
//  mini-pools-ios
//
//  Created by Davidson, Shay on 31/01/2019.
//  Copyright © 2019 Kaplún, Sebi. All rights reserved.
//

import UIKit

class PoolFormPresenter: NSObject, FormViewPresenter {
  unowned let view: FormView
  var model: AbstractPoolModel?
  let router: UINavigationController
  
  required init(view: FormView, model: AbstractPoolModel? = nil, router: UINavigationController) {
    self.view = view
    self.model = model
    self.router = router
    super.init()
  }
  
  func setup() {
    
  }
  
  func setFieldValue(at index: Int, value: String) {
    
  }
  
  func selectedAction() {
    fatalError("needs to be overriden")
  }
}

class CreatePoolPresenter: PoolFormPresenter {
  required init(view: FormView, model: AbstractPoolModel? = nil, router: UINavigationController) {
    super.init(view: view, model: NewPoolModel(), router: router)
  }
}

class EditPoolPresenter: PoolFormPresenter {

}

