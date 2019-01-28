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
  
  private let searchBar = UISearchBar()
  private let tableView = UITableView()
  
  // MARK: Life-cycle
  
  override func loadView() {
    super.loadView()
    self.view.addSubview(searchBar)
    self.view.addSubview(tableView)
    self.searchBar.translatesAutoresizingMaskIntoConstraints = false
    self.tableView.translatesAutoresizingMaskIntoConstraints = false
    
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Mini Pools"
    self.searchBar.delegate = self
    self.tableView.delegate = self
  }
  
  // MARK - UISearchBarDelegate
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    // IMPLEMENT (filtering by pool name)
  }
  
  // MARK - UITableViewDelegate
  
  func tableView(_tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
    // IMPLEMENT (go to pool page)
  }
  
  // MARK - UITableViewDataSource
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // IMPLEMENT (pools count)
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // IMPLEMENT (return pool cell with details)
    return UITableViewCell()
  }
  
}
