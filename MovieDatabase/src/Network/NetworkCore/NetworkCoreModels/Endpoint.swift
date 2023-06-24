//
//  Endpoint.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 24.06.2023.
//

import Foundation

protocol Endpointable {
  var scheme: String { get }
  var host: String { get }
  var path: String { get }
  var queryItems: [URLQueryItem] { get }
  
  func makeRequest() -> URLRequest?
}
