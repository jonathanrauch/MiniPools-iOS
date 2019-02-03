//
//  PoolViewController.swift
//  mini-pools-ios
//
//  Created by Davidson, Shay on 28/01/2019.
//  Copyright © 2019 Kaplún, Sebi. All rights reserved.
//

import UIKit

class PoolViewController: UIViewController, PoolView {
  
  private lazy var presenter: PoolPresenter = PoolPresenter(view: self, model: model)
  private let model: PoolModel
  
  init(model: PoolModel) {
    self.model = model
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Layout
  
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
    self.presenter.renderPool()
  }
  
  // MARK: PoolView
  
  func toggleSpinner(value: Bool) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = value
  }
  
  func toggleInteraction(value: Bool) {
    self.navigationItem.leftBarButtonItem?.isEnabled = value
    self.deleteButton.isEnabled = value
    self.editButton.isEnabled = value
  }
  
  func setTitle(title: String) {
    self.title = title
  }
  
  func setName(name: String) {
    self.nameLabel.text = name
  }
  
  func setAmount(amount: String) {
     self.amountLabel.text = amount
  }
  
  func navigateToEditPoolPage() {
    self.navigationController?.pushViewController(PoolFormViewController(model: self.model), animated: true)
  }
  
  func navigateToHomePage() {
    self.navigationController?.popViewController(animated: true)
  }
  
  // MARK - UIButton handlers
  
  @objc func handleDelete() {
    self.presenter.selectedDelete()
  }
  
  @objc func handleEdit() {
    self.presenter.selectedEdit()
  }
  
}
