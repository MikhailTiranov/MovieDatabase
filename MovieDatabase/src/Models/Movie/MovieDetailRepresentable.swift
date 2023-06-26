//
//  MovieDetailRepresentable.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 24.06.2023.
//

import Foundation

protocol MovieDetailRepresentable {
  var minutesDuration: String { get }
  var starsReview: String { get }
  var backdropPath: String? { get }
  var title: String { get }
  var allGenres: String? { get }
  var fullReleaseDate: String { get }
  var overview: String { get }
}
