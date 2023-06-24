//
//  Collection+Extension.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 24.06.2023.
//

import Foundation

extension Collection {
  subscript(safe i: Index) -> Iterator.Element? {
    indices.contains(i) ? self[i] : nil
  }
}
