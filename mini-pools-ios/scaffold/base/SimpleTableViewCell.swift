//
//  SimpleTableViewCell.swift
//  mini-pools-ios
//
//  Created by Davidson, Shay on 04/02/2019.
//  Copyright © 2019 Kaplún, Sebi. All rights reserved.
//

import UIKit

class SimpleTableViewCell: UITableViewCell {
  
  convenience init() {
    self.init(style: .subtitle, reuseIdentifier: "cell")
  }
  
  func setTitle(_ text: String) {
    self.textLabel?.text = text
  }
  
  func setSubtitle(_ text: String) {
    self.detailTextLabel?.text = text
  }
}
