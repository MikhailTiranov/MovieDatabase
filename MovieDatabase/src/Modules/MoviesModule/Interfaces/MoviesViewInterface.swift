//
//  MoviesViewInterface.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 24.06.2023.
//

protocol MoviesViewInterface: AnyObject {
  var presenter: MoviesPresenterInterface! { get set }
}
