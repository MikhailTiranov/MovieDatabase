//
//  Movie.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 24.06.2023.
//

import Foundation

struct Movie: Codable {
  
  // MARK: - Public (Properties)
  let title: String
  let year: String
  let rated: String
  let runtime: String
  let genre: String
  let director: String
  let actors: String
  let plot: String
  let imdbRating: String
  let imdbID: String
  let poster: String
  var images: Images?
}

extension Movie {
  struct Images: Codable {
    let backdropPath: String
    let posterPath: String
  }
}

extension Movie {
  static var mockMovies: [String] {
    [
      "tt0111161",
      "tt0109830",
      "tt1375666",
      "tt0468569",
      "tt0068646",
      "tt0137523",
      "tt0102926",
      "tt0133093",
      "tt0172495",
      "tt1853728",
      "tt0268978",
      "tt1675434",
      "tt0099685",
      "tt0482571",
      "tt0088763",
      "tt0407887",
      "tt0208092",
      "tt0120689",
      "tt0993846",
      "tt0167404",
      "tt1130884",
      "tt0758758",
      "tt6966692",
      "tt0816692",
      "tt0078748",
      "tt0110912",
      "tt0332452",
      "tt0110357",
      "tt0066921",
      "tt2267998"
    ]
  }
}
