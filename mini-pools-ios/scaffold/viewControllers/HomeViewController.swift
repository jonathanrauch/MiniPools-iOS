//
//  HomeViewController.swift
//  mini-pools-ios
//
//  Created by Davidson, Shay on 28/01/2019.
//  Copyright © 2019 Kaplún, Sebi. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
  
  // MARK: Scaffold - don't touch this - hammer time! 🔨
  
  private let searchBar = UISearchBar()
  private let tableView = UITableView()
  private var pools = [PoolModel]()
  private var filteredPools = [PoolModel]()
  
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
    self.tableView.dataSource = self
    
    tableView.register(PoolTableViewCell.self, forCellReuseIdentifier: PoolTableViewCell.defaultReuseIdentifier)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // IMPLEMENT (fetch and render pools, show ios top-bar activity indicator while fetching - `UIApplication.shared.isNetworkActivityIndicatorVisible = value`)
    
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    API.fetchPools { (pools) in
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      self.pools = pools
      self.filteredPools = pools
      self.tableView.reloadData()
    }
  }
  
  // MARK - UISearchBarDelegate
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    // IMPLEMENT (filtering by pool name)
    filteredPools = searchText.isEmpty ? pools : pools.filter { (item: PoolModel) -> Bool in
      // Simple contains case-insensitive search
      return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
    }
    
    tableView.reloadData()
  }
  
  // MARK - UITableViewDelegate
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // IMPLEMENT (push pool page to navigation stack)
    let poolVC = PoolViewController()
    poolVC.pool = filteredPools[indexPath.row]
    tableView.deselectRow(at: indexPath, animated: true)
    self.navigationController?.pushViewController(poolVC, animated: true)
  }
  
  // MARK - UITableViewDataSource
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // IMPLEMENT (pools count)
    return filteredPools.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: PoolTableViewCell.defaultReuseIdentifier, for: indexPath) as? PoolTableViewCell
      else { return UITableViewCell() }
    cell.render(pool: filteredPools[indexPath.row])
    return cell
  }
  
}
