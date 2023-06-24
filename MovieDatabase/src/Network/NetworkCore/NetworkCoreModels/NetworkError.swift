//
//  NetworkError.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 24.06.2023.
//

import Foundation

enum NetworkError: Error {
  case apiError
  case invalidEndpoint
  case invalidResponse
  case noData
  case serializationError
}
