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
  private let nameTextField = UILabel()
  private let goalAmountTextField = UILabel()
  private let actionButton = UIButton(type: .system)
  
  override func loadView() {
    super.loadView()
    
    self.view.backgroundColor = UIColor.white
    
    self.view.addSubview(nameLabel)
    self.view.addSubview(amountLabel)
    self.view.addSubview(deleteButton)
    self.view.addSubview(editButton)
    
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
    self.amountLabel.translatesAutoresizingMaskIntoConstraints = false
    self.deleteButton.translatesAutoresizingMaskIntoConstraints = false
    self.editButton.translatesAutoresizingMaskIntoConstraints = false
    
    self.deleteButton.setTitle("Delete", for: .normal)
    self.editButton.setTitle("Edit", for: .normal)
    
    self.nameLabel.font = self.nameLabel.font.withSize(30)
    self.nameLabel.textAlignment = .center
    self.amountLabel.textAlignment = .center
    
    self.nameLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(20)
      make.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin)
      make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin)
    }
    
    self.amountLabel.snp.makeConstraints { make in
      make.top.equalTo(nameLabel.snp.bottom).offset(20)
      make.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin)
      make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin)
    }
    
    self.deleteButton.snp.makeConstraints { make in
      make.top.equalTo(amountLabel.snp.bottom).offset(30)
      make.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin)
      make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin)
    }
    
    self.editButton.snp.makeConstraints { make in
      make.top.equalTo(deleteButton.snp.bottom).offset(10)
      make.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin)
      make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin)
    }
    
    self.actionButton.addTarget(self, action: #selector(handleAction), for: .touchUpInside)
  }
  
  // MARK: Life-cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "" // IMPLEMENT (pool name or "create new pool")
  }
  
  // MARK - UIButton handlers
  
  @objc func handleAction() {
    // IMPLEMENT (perform action - create or edit)
  }
  
}
