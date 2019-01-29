//
//  PoolFormViewController.swift
//  mini-pools-ios
//
//  Created by Davidson, Shay on 28/01/2019.
//  Copyright © 2019 Kaplún, Sebi. All rights reserved.
//

import UIKit

class PoolFormViewController: UIViewController {
  
  // MARK: Scaffold - don't touch this - hammer time! 🔨
  
  private let nameLabel = UILabel()
  private let goalAmountLabel = UILabel()
  private let nameTextField = UITextField()
  private let goalAmountTextField = UITextField()
  private let actionButton = UIButton(type: .system)
  
  override func loadView() {
    super.loadView()
    
    self.view.backgroundColor = UIColor.white
    
    self.view.addSubview(nameLabel)
    self.view.addSubview(goalAmountLabel)
    self.view.addSubview(nameTextField)
    self.view.addSubview(goalAmountTextField)
    self.view.addSubview(actionButton)
    
    actionButton.backgroundColor = UIColor.lightGray
    actionButton.setTitleColor(UIColor.white, for: .normal)
    
    self.nameLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(20)
      make.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).offset(20)
      make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).offset(-20)
    }
    
    self.nameTextField.snp.makeConstraints { make in
      make.top.equalTo(nameLabel.snp.bottom)
      make.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).offset(20)
      make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).offset(-20)
    }
    
    self.goalAmountLabel.snp.makeConstraints { make in
      make.top.equalTo(nameTextField.safeAreaLayoutGuide.snp.topMargin).offset(40)
      make.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).offset(20)
      make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).offset(-20)
    }
    
    self.goalAmountTextField.snp.makeConstraints { make in
      make.top.equalTo(goalAmountLabel.snp.bottom)
      make.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).offset(20)
      make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).offset(-20)
    }
    
    self.actionButton.snp.makeConstraints { make in
      make.top.equalTo(goalAmountTextField.snp.bottom).offset(20)
      make.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).offset(20)
      make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).offset(-20)
    }
    
    self.nameLabel.text = "Pool Name"
    self.goalAmountLabel.text = "Amount Goal"
    self.nameTextField.placeholder = "required"
    self.goalAmountTextField.placeholder = "optional"
    self.goalAmountTextField.keyboardType = .numberPad
    
    self.actionButton.addTarget(self, action: #selector(handleAction), for: .touchUpInside)
  }
  
  // MARK: Life-cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "" // IMPLEMENT (pool name or "create new pool")
    self.actionButton.setTitle("action", for: .normal) // IMPLEMENT (correct button name)
    self.nameTextField.text = "aasas" // IMPLEMENT (pool name in case of edit)
    self.goalAmountTextField.text = "" // IMPLEMENT (goal amount in case of edit)
  }
  
  // MARK - UIButton handlers
  
  @objc func handleAction() {
    // IMPLEMENT (perform action - create or edit)
  }
  
}
