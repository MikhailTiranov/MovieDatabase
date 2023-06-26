//
//  MovieCellRepresentable.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 24.06.2023.
//

import Foundation

protocol MovieCellRepresentable {
  var title: String { get }
  
  var posterPath: String? { get }
  var genreAndYear: String { get }
  var duration: String { get }
  var attributedReview: NSAttributedString { get }
}
