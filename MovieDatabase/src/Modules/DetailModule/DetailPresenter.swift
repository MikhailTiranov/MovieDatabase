//
//  DetailPresenter.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 26.06.2023.
//

import Foundation

class DetailPresenter {
  
  // MARK: - Public (Properties)
  var isAlreadyInCollection: Bool {
    true
  }
  
  // MARK: - Private (Properties)
  private var movie: MovieDetailRepresentable?
  
  // MARK: - DetailPresenterInterface
  weak var viewInterface: DetailViewInterface!
  
  // MARK: - Init
  init(with movie: MovieDetailRepresentable) {
    self.movie = movie
  }
  
  // MARK: - Private (Interface)
  private func updateView() {
    guard let movie else { return }
    viewInterface.updateMovie(movie)
    
    fetchImage(with: movie.backdropPath)
  }
}

extension DetailPresenter: DetailPresenterInterface {
  func handleOnViewLoad() {
    updateView()
  }
  
  func fetchImage(with url: String?) {
    if let url {
      TMDBService
        .shared
        .fetchImage(path: url) { image in
          DispatchQueue.main.async {
            self.viewInterface.updateImage(image)
          }
        } errorHandler: { error in
          self.viewInterface.updateImage(nil)
        }
    } else {
      viewInterface.updateImage(nil)
    }
  }
  
  func handleCollectionButtonTapped() {
    viewInterface.dismiss()
  }
}
