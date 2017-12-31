//
//  Extensions.swift
//  mini-pools-ios
//
//  Created by Kaplún, Sebi on 12/20/17.
//  Copyright © 2017 Kaplún, Sebi. All rights reserved.
//

import Foundation

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
