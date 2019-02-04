//
//  DetailsViewController.swift
//  mini-pools-ios
//
//  Created by Davidson, Shay on 28/01/2019.
//  Copyright © 2019 Kaplún, Sebi. All rights reserved.
//

import UIKit
import SnapKit

typealias ActionHandler = () -> Void

protocol DetailsViewPresenter {
  func setup()
}

protocol DetailsView: class {
  func setTitle(_ title: String)
  func toggleSpinner(value: Bool)
  func toggleInteraction(value: Bool)
  func addDetail(text: String, size: DetailsLabelSize)
  func addButton(text: String, handler: ActionHandler)
}

enum DetailsLabelSize: CGFloat {
  case big = 32.0
  case small = 16.0
}

class DetailsViewController: UIViewController, DetailsView {

  // MARK: Init
  
  var presenter: DetailsViewPresenter! {
    didSet {
      presenter.setup()
    }
  }
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Layout
  
  private var labels: [UILabel] = []
  private var buttons: [UIButton] = []
  
  override func loadView() {
    super.loadView()
    self.view.backgroundColor = UIColor.white
  }
  
  // MARK: DetailsViews
  
  func setTitle(_ title: String) {
    self.title = title
  }
  
  func toggleSpinner(value: Bool) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = value
  }
  
  func toggleInteraction(value: Bool) {
    self.navigationItem.leftBarButtonItem?.isEnabled = value
    self.buttons.forEach { $0.isEnabled = value }
  }
  
  func addDetail(text: String, size: DetailsLabelSize) {
    let detailsLabel = UILabel()
    self.view.addSubview(detailsLabel)
    
    detailsLabel.textAlignment = .center
    detailsLabel.font = detailsLabel.font.withSize(size.rawValue)
    detailsLabel.text = text
    
    let lastSnapPoint = self.labels.isEmpty ? view.safeAreaLayoutGuide.snp.topMargin : self.labels.last!.snp.bottom
    
    detailsLabel.snp.makeConstraints { make in
      make.top.equalTo(lastSnapPoint).offset(20)
      make.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin)
      make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin)
    }
    
    self.labels.append(detailsLabel)
  }
  
  func addButton(text: String, handler: () -> Void) {
    
  }
}
//
//
//
//self.view.addSubview(nameLabel)
//self.view.addSubview(amountLabel)
//self.view.addSubview(deleteButton)
//self.view.addSubview(editButton)
//
//self.deleteButton.setTitle("Delete", for: .normal)
//self.editButton.setTitle("Edit", for: .normal)
//
//self.nameLabel.font = self.nameLabel.font.withSize(30)
//self.nameLabel.textAlignment = .center
//self.amountLabel.textAlignment = .center
//
//
//
//self.amountLabel.snp.makeConstraints { make in
//  make.top.equalTo(nameLabel.snp.bottom).offset(20)
//  make.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin)
//  make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin)
//}
//
//self.deleteButton.snp.makeConstraints { make in
//  make.top.equalTo(amountLabel.snp.bottom).offset(30)
//  make.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin)
//  make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin)
//}
//
//self.editButton.snp.makeConstraints { make in
//  make.top.equalTo(deleteButton.snp.bottom).offset(10)
//  make.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin)
//  make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin)
//}
//
//self.deleteButton.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
//self.editButton.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)
