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

extension UINavigationController {
  func popAndPush(_ vc: UIViewController, animated: Bool) {
    var viewControllers = self.viewControllers
    viewControllers[viewControllers.count - 1] = vc
    setViewControllers(viewControllers, animated: animated)
  }
}

extension UIView {
  func shake() {
    let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    animation.duration = 0.6
    animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0]
    layer.add(animation, forKey: "shake")
  }
}

class ClosureSleeve {
  let closure: ()->()
  
  init (_ closure: @escaping ()->()) {
    self.closure = closure
  }
  
  @objc func invoke () {
    closure()
  }
}

extension UIControl {
  func addAction(for controlEvents: UIControl.Event, _ closure: @escaping ()->()) {
    let sleeve = ClosureSleeve(closure)
    addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
    objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
  }
}

typealias ActionHandler = () -> Void

