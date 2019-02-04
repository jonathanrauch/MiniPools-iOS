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
  func addButton(text: String, handler: @escaping ActionHandler)
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
  
  func addButton(text: String, handler: @escaping ActionHandler) {
    let button = UIButton()
    self.view.addSubview(button)
    
    button.backgroundColor = UIColor.gray
    button.setTitle(text, for: .normal)
    button.setTitleColor(UIColor.white, for: .normal)
    button.setTitleColor(UIColor.lightGray, for: .disabled)
    button.setTitleColor(UIColor.yellow, for: .highlighted)
    
    var lastSnapPoint: ConstraintRelatableTarget?
    var offset: Int?
    if self.labels.isEmpty && self.buttons.isEmpty {
      lastSnapPoint = view.safeAreaLayoutGuide.snp.topMargin
      offset = 20
    } else if !self.buttons.isEmpty {
      lastSnapPoint = self.buttons.last!.snp.bottom
      offset = 20
    } else {
      lastSnapPoint = self.labels.last!.snp.bottom
      offset = 40
    }
    
    button.snp.makeConstraints { make in
      make.top.equalTo(lastSnapPoint!).offset(offset!)
      make.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).offset(20)
      make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).offset(-20)
    }
    
    button.addAction(for: .touchUpInside, handler)
    
    self.buttons.append(button)
  }
}
