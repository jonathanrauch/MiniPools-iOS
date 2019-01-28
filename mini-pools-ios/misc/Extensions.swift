//
//  Extensions.swift
//  mini-pools-ios
//
//  Created by Kaplún, Sebi on 12/20/17.
//  Copyright © 2017 Kaplún, Sebi. All rights reserved.
//

import UIKit

extension Date {
  func shortDate() -> String {
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "MMM d, yyyy"
    return dateformatter.string(from: self)
  }
}

extension String {
  func getSymbolForCurrencyCode() -> String {
    let locale = NSLocale(localeIdentifier: self)
    return locale.displayName(forKey: NSLocale.Key.currencySymbol, value: self) ?? self
  }
}

class DateUtil {
  static func initDate(string : String) -> Date? {
    let dateFor: DateFormatter = DateFormatter()
    dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    return dateFor.date(from: string)
  }
}

extension UIView {
  
  func size(width: CGFloat, height: CGFloat) {
    NSLayoutConstraint.activate([
      self.widthAnchor.constraint(equalToConstant: width),
      self.heightAnchor.constraint(equalToConstant: height)
    ])
  }
  
  func edges(_ edges: UIRectEdge, to view: UIView, offset: UIEdgeInsets) {
    if edges.contains(.top) || edges.contains(.all) {
      self.topAnchor.constraint(equalTo: view.topAnchor, constant: offset.top).isActive = true
    }
    
    if edges.contains(.bottom) || edges.contains(.all) {
      self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: offset.bottom).isActive = true
    }
    
    if edges.contains(.left) || edges.contains(.all) {
      self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset.left).isActive = true
    }
    
    if edges.contains(.right) || edges.contains(.all) {
      self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: offset.right).isActive = true
    }
  }
  
  func neighbour(_ edges: UIRectEdge, to view: UIView, offset: UIEdgeInsets) {
    if edges.contains(.top) {
      self.topAnchor.constraint(equalTo: view.bottomAnchor, constant: offset.top).isActive = true
    }
    
    if edges.contains(.bottom) {
      self.bottomAnchor.constraint(equalTo: view.topAnchor, constant: offset.bottom).isActive = true
    }
    
    if edges.contains(.left) {
      self.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: offset.left).isActive = true
    }
    
    if edges.contains(.right)  {
      self.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset.right).isActive = true
    }
  }
  
  var safeTopAnchor: NSLayoutYAxisAnchor {
    if #available(iOS 11.0, *) {
      return self.safeAreaLayoutGuide.topAnchor
    } else {
      return self.topAnchor
    }
  }
  
  var safeLeftAnchor: NSLayoutXAxisAnchor {
    if #available(iOS 11.0, *){
      return self.safeAreaLayoutGuide.leftAnchor
    }else {
      return self.leftAnchor
    }
  }
  
  var safeRightAnchor: NSLayoutXAxisAnchor {
    if #available(iOS 11.0, *){
      return self.safeAreaLayoutGuide.rightAnchor
    }else {
      return self.rightAnchor
    }
  }
  
  var safeBottomAnchor: NSLayoutYAxisAnchor {
    if #available(iOS 11.0, *) {
      return self.safeAreaLayoutGuide.bottomAnchor
    } else {
      return self.bottomAnchor
    }
  }
}
