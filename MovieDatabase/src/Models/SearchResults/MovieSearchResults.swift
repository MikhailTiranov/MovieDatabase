//
//  MovieSearchResults.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 26.06.2023.
//

struct MovieSearchResults: Codable {
  
  // MARK: - Public (Properties)
  let page: Int
  let results: [Movie]
}
