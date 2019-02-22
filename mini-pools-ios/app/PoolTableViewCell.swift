//
//  PoolTableViewCell.swift
//  mini-pools-ios
//
//  Created by Jonathan Rauch on 2/22/19.
//  Copyright © 2019 Jonathan Rauch. All rights reserved.
//

import UIKit

class PoolTableViewCell: UITableViewCell {
  static var defaultReuseIdentifier: String {
    return NSStringFromClass(self)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func render(pool: PoolModel) {
    textLabel?.text = pool.name
    // IMPLEMENT (pool amount)
    if let goalAmount = pool.goalAmountValue {
      detailTextLabel?.text = "$\(pool.contributionsSum) / $\(goalAmount)"
    } else {
      detailTextLabel?.text = "$\(pool.contributionsSum)"
    }
  }
}
