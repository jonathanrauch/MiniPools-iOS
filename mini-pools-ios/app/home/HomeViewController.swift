//
//  HomeViewController.swift
//  mini-pools-ios
//
//  Created by Davidson, Shay on 28/01/2019.
//  Copyright © 2019 Kaplún, Sebi. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, HomeView {
  private lazy var presenter = HomePresenter(view: self, model: HomeModel(pools: [], searchFilter: nil))
  private var dataSource: HomeDataSource?
  
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
    self.title = "Mini Pools"
    self.searchBar.delegate = self
    self.tableView.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.presenter.loadPools() // TODO: who initiates this?
  }
  
  // MARK - HomeView
  
  func toggleSpinner(value: Bool) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = value
  }
  
  func setDataSource(_ dataSource: HomeDataSource) { // TODO bahahaha
    self.dataSource = dataSource
    self.tableView.dataSource = dataSource
    self.tableView.reloadData()
  }
  
  func navigateToCreatePoolPage() { // TODO: navigation?
    self.navigationController?.pushViewController(PoolFormViewController(), animated: true)
  }
  
  func navigateToPoolPage(_ pool: PoolModel) {
    self.navigationController?.pushViewController(PoolViewController(model: pool), animated: true)
  }
  
  // MARK - UISearchBarDelegate
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    self.presenter.filterPools(stringFilter: searchText)
  }
  
  // MARK - UITableViewDelegate
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.presenter.selectedItem(at: indexPath)
  }
}
