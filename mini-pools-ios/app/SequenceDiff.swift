//
//  SequenceDiff.swift
//  mini-pools-ios
//
//  Created by Jonathan Rauch on 2/22/19.
//  Copyright © 2019 Kaplún, Sebi. All rights reserved.
//

import Foundation

// Adapted from: https://medium.com/grand-parade/computing-the-diff-of-two-arrays-in-a-functional-way-in-swift-be82a586a821
// to add indexes, for use in tableViews
public struct SequenceDiff<T1, T2> {
  public let common: [(Int, T1, T2)]
  public let removed: [(Int,T1)]
  public let inserted: [(Int,T2)]
  public init(common: [(Int, T1, T2)] = [], removed: [(Int,T1)] = [], inserted: [(Int,T2)] = []) {
    self.common = common
    self.removed = removed
    self.inserted = inserted
  }
}

public func sequenceDiff<T1, T2>(_ first: [T1], _ second: [T2], with compare: (T1,T2) -> Bool) -> SequenceDiff<T1, T2> {
  let combinations = first.enumerated().compactMap { (index,firstElement) in (index,firstElement, second.first { secondElement in compare(firstElement, secondElement) }) }
  let common = combinations.filter { $0.2 != nil }.compactMap { ($0.0, $0.1, $0.2!) }
  let removed = combinations.filter { $0.2 == nil }.compactMap { ($0.0, $0.1) }
  let inserted = second.enumerated().filter { (index,secondElement) in !common.contains { compare($0.1, secondElement) } }.compactMap { ($0.offset, $0.element) }
  
  return SequenceDiff(common: common, removed: removed, inserted: inserted)
}
