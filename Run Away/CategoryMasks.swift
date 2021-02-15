//
//  CategoryMasks.swift
//  Run Away
//
//  Created by paw on 15.02.2021.
//

import Foundation

struct CategoryMask: OptionSet {
   let rawValue: UInt32
   static let categoryMask = CategoryMask (rawValue: 1 << 0)
   static let collisionMask = CategoryMask (rawValue: 1 << 1)
}
