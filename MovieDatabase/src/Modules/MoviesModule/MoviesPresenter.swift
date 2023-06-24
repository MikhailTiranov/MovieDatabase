//
//  MoviesPresenter.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 24.06.2023.
//

import Foundation

class MoviesPresenter {
  
  // MARK: - MoviesPresenterInterface
  var movieIds: [String] = Movie.mockMovies
  var movies: [Movie] = []

  // MARK: - Public (Properties)
  weak var moviesViewController: MoviesViewInterface?
  
  // MARK: - Init
  init(with viewController: MoviesViewController) {
    moviesViewController = viewController
  }
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
