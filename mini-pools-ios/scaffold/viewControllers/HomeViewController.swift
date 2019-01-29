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
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // IMPLEMENT (fetch and render pools, show ios top-bar activity indicator while fetching - `UIApplication.shared.isNetworkActivityIndicatorVisible = value`)
  }
  
  // MARK - UISearchBarDelegate
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    // IMPLEMENT (filtering by pool name)
  }
  
  // MARK - UITableViewDelegate
  
  func tableView(_tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
    // IMPLEMENT (push pool page to navigation stack)
  }
  
  // MARK - UITableViewDataSource
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // IMPLEMENT (pools count)
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "poolCell")
    cell.textLabel?.text = "pool" // IMPLEMENT (pool name)
    cell.detailTextLabel?.text = "$0.00" // IMPLEMENT (pool amount)
    return cell
  }
  
}
