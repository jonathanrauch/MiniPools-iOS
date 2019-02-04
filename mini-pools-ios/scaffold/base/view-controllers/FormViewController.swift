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
  func changedFieldValue(at index: Int, value: String)
  func selectedAction()
}

protocol FormView: class {
  func setTitle(_ title: String)
  func setActionTitle(_ title: String)
  func toggleSpinner(value: Bool)
  func toggleInteraction(value: Bool)
  func addField(label: String, placeholder: String?, prefilledValue: String?)
  func shakeField(at index: Int)
}

class FormViewController: UIViewController, FormView {
  
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
    button.backgroundColor = UIColor.gray
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
  
  func addField(label: String, placeholder: String?, prefilledValue: String?) {
    let labelView = UILabel()
    let textField = UITextField()
    self.view.addSubview(labelView)
    self.view.addSubview(textField)
    
    let lastSnapPoint = self.fields.isEmpty ? view.safeAreaLayoutGuide.snp.topMargin : self.fields.last!.textField.snp.bottom
    
    labelView.snp.makeConstraints { make in
      make.top.equalTo(lastSnapPoint).offset(20)
      make.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).offset(20)
      make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).offset(-20)
    }
  
    textField.snp.makeConstraints { make in
      make.top.equalTo(labelView.snp.bottom)
      make.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).offset(20)
      make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).offset(-20)
      make.bottom.equalTo(self.button!.snp.top).offset(-40).priority(500 + self.fields.count)
    }
    
    labelView.text = label
    textField.backgroundColor = UIColor.lightGray
    textField.placeholder = placeholder
    textField.text = prefilledValue
    textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    
    self.fields.append((label: labelView, textField: textField))
  }
  
  func shakeField(at index: Int) {
    self.fields[index].textField.shake()
  }

  
  // MARK - Private
  
  @objc func textFieldDidChange(textField: UITextField) {
    if let textFieldIndex = self.fields.firstIndex(where: { $0.textField == textField }) {
      self.presenter.changedFieldValue(at: textFieldIndex, value: textField.text ?? "")
    }
  }
  
  @objc func handleAction() {
    self.presenter.selectedAction()
  }
}
