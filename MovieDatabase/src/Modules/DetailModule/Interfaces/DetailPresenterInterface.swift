//
//  DetailPresenterInterface.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 24.06.2023.
//

import UIKit

protocol DetailPresenterInterface: AnyObject {
  var viewInterface: DetailViewInterface! { get set }
  var isAlreadyInCollection: Bool { get }
  
  func handleOnViewLoad()
  func handleCollectionButtonTapped()
}
