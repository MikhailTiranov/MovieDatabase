//
//  MoviesPresenterInterface.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 24.06.2023.
//

protocol MoviesPresenterInterface: AnyObject {
  var viewInterface: MoviesViewInterface! { get set }
  
  var movies: [Movie] { get }
  func fetchMovies(completionBlock: @escaping CompletionBlock)
}
