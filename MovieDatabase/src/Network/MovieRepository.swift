//
//  MovieRepository.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 24.06.2023.
//

import UIKit

protocol MovieRepository: AnyObject {
  func fetchMovie(
    with imdbID: String,
    successHandler: @escaping (_ response: Movie) -> (),
    errorHandler: @escaping(_ error: NetworkError) -> ()
  )
  func searchMovie(
    with title: String,
    successHandler: @escaping (_ response: [Movie]) -> (),
    errorHandler: @escaping(_ error: NetworkError) -> ()
  )
  func fetchImage(
    path: String,
    successHandler: @escaping (_ response: UIImage) -> (),
    errorHandler: @escaping(_ error: NetworkError) -> ()
  )
}
