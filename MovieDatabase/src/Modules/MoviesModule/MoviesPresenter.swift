//
//  MoviesPresenter.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 24.06.2023.
//

import Foundation

class MoviesPresenter: MoviesPresenterInterface {
  
  // MARK: - MoviesPresenterInterface
  var movies: [Movie] = []

  // MARK: - Public (Properties)
  weak var moviesViewController: MoviesViewInterface?
  
  // MARK: - Init
  init(with viewController: MoviesViewController) {
    moviesViewController = viewController
  }
}
