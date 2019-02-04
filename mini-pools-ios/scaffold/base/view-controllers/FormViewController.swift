//
//  FormViewController.swift
//  mini-pools-ios
//
//  Created by Davidson, Shay on 28/01/2019.
//  Copyright © 2019 Kaplún, Sebi. All rights reserved.
//

import UIKit
import SnapKit

protocol FormViewPresenter {
  func setup()
  func setFieldValue(at index: Int, value: String)
  func selectedAction()
}

protocol FormView: class {
  func setTitle(_ title: String)
  func setActionTitle(_ title: String)
  func toggleSpinner(value: Bool)
  func toggleInteraction(value: Bool)
  func addField(label: String, placeholder: String, prefilledValue: String)
  func shakeField(at index: Int)
}

class FormViewController: UIViewController, UITextFieldDelegate, FormView {
  
  // MARK: Init
  
  var presenter: FormViewPresenter! {
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
  
  private var fields: [(label: UILabel, textField: UITextField)] = []
  private var button: UIButton?
  
  override func loadView() {
    super.loadView()
    self.view.backgroundColor = UIColor.white
    
    let button = UIButton()
    button.setTitleColor(UIColor.white, for: .normal)
    button.setTitleColor(UIColor.lightGray, for: .disabled)
    button.setTitleColor(UIColor.yellow, for: .highlighted)
    self.view.addSubview(button)
    
    button.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(20).priority(250)
      make.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).offset(20)
      make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).offset(-20)
    }
    
    button.addTarget(self, action: #selector(handleAction), for: .touchUpInside)
    
    self.button = button
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
    self.fields.forEach { $0.textField.isEnabled = value }
    self.button?.isEnabled = value
  }
  
  func setActionTitle(_ title: String) {
    self.button?.setTitle(title, for: .normal)
  }
  
  func addField(label: String, placeholder: String, prefilledValue: String) {
    let label = UILabel()
    let textField = UITextField()
    self.view.addSubview(label)
    self.view.addSubview(textField)
    
    let lastSnapPoint = self.fields.isEmpty ? view.safeAreaLayoutGuide.snp.topMargin : self.fields.last!.textField.snp.bottom
    
    label.snp.makeConstraints { make in
      make.top.equalTo(lastSnapPoint).offset(20)
      make.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).offset(20)
      make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).offset(-20)
    }
  
    textField.snp.makeConstraints { make in
      make.top.equalTo(label.snp.bottom)
      make.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).offset(20)
      make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).offset(-20)
    }
    
    self.fields.append((label: label, textField: textField))
  }
  
  func shakeField(at index: Int) {
    self.fields[index].textField.shake()
  }
  
  // MARK - Private
  
  @objc func handleAction() {
    self.presenter.selectedAction()
  }
}
