//
//  PoolViewController.swift
//  mini-pools-ios
//
//  Created by Davidson, Shay on 28/01/2019.
//  Copyright © 2019 Kaplún, Sebi. All rights reserved.
//

import UIKit

class PoolViewController: UIViewController {
  
  // MARK: Scaffold - don't touch this - hammer time! 🔨
  
  private let nameLabel = UILabel()
  private let amountLabel = UILabel()
  private let deleteButton = UIButton(type: .system)
  private let editButton = UIButton(type: .system)
  
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
    
    self.deleteButton.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
    self.editButton.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)
  }
  
  // MARK: Life-cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "" // IMPLEMENT (pool name)
    
    self.nameLabel.text = "pool" // IMPLEMENT (pool name)
    self.amountLabel.text = "$0 / $0" // IMPLEMENT (accumulated amount + goal)
  }
  
  // MARK - UIButton handlers
  
  @objc func handleDelete() {
    // IMPLEMENT (delete action)
  }
  
  @objc func handleEdit() {
    // IMPLEMENT (edit action)
  }
  
}
