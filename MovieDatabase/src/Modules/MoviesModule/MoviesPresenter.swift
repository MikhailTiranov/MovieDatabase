//
//  MoviesPresenter.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 24.06.2023.
//

import Foundation

class MoviesPresenter {
  
  // MARK: - Public (Properties)
  var movieIds: [String] = Movie.mockMovies
  
  // MARK: - MoviesPresenterInterface
  var movies: [Movie] = []

  weak var viewInterface: MoviesViewInterface!
}

extension MoviesPresenter: MoviesPresenterInterface {
  func fetchMovies(completionBlock: @escaping CompletionBlock) {
    var newMovies: [Movie] = []
    
    movieIds.forEach {
      TMDBService.shared.fetchMovie(with: $0) {
        newMovies.append($0)
        
        if newMovies.count == self.movieIds.count {
          self.movies = newMovies
          completionBlock()
        }
        
      } errorHandler: { error in
        
      }
    }
  }
}
