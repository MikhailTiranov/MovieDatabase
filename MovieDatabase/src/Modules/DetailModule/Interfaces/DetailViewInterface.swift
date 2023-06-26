//
//  DetailViewInterface.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 24.06.2023.
//

import UIKit

protocol DetailViewInterface: AnyObject {
  var presenter: DetailPresenterInterface! { get set }
  
  func updateImage(_ image: UIImage?)
  func updateMovie(_ movie: MovieDetailRepresentable?)
  func dismiss()
}
