//
//  TableViewController.swift
//  mini-pools-ios
//
//  Created by Davidson, Shay on 28/01/2019.
//  Copyright © 2019 Kaplún, Sebi. All rights reserved.
//

import UIKit
import SnapKit

protocol TableViewPresenter: UITableViewDataSource {
  func setup()
  func loadData()
  func changedTableFilter(_ filter: String)
  func selectedTableItem(at indexPath: IndexPath)
}

protocol TableView: class {
  func setTitle(_ title: String)
  func toggleSpinner(value: Bool)
  func refreshTable()
}

class TableViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, TableView {

  // MARK: Init
  
  var presenter: TableViewPresenter! {
    didSet {
      presenter.setup()
    }
  }
  var dataSource: UITableViewDataSource?
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Layout
  
  private let searchBar = UISearchBar()
  private let tableView = UITableView()
  
  override func loadView() {
    super.loadView()
    
    self.view.backgroundColor = UIColor.white
    
    self.view.addSubview(searchBar)
    self.view.addSubview(tableView)
    
    self.searchBar.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
      make.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin)
      make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin)
      make.bottom.equalTo(tableView.snp.top)
    }
    
    self.tableView.snp.makeConstraints { make in
      make.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin)
      make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
    }
  }
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.white
    self.searchBar.delegate = self
    self.tableView.delegate = self
    self.tableView.dataSource = self.presenter
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.presenter.loadData()
  }
  
  // MARK - HomeView
  
  func setTitle(_ title: String) {
    self.title = title
  }
  
  func toggleSpinner(value: Bool) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = value
  }
  
  func refreshTable() {
    let range = NSMakeRange(0, self.tableView.numberOfSections)
    let sections = NSIndexSet(indexesIn: range)
    self.tableView.reloadSections(sections as IndexSet, with: .automatic)
  }

  // MARK - UISearchBarDelegate
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    self.presenter.changedTableFilter(searchText)
  }
  
  // MARK - UITableViewDelegate
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.presenter.selectedTableItem(at: indexPath)
  }
}
