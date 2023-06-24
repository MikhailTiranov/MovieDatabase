//
//  TMDBEndpoint.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 24.06.2023.
//

import Foundation

enum TMDBEndpoint {
  case search(String)
  case fetch(String)
  case image(String)
  
  private var apiKey: String { "4f1faf5a9dee6e8121f1f7493f18c404" }
}

extension TMDBEndpoint: Endpointable {
  var scheme: String { "https" }
  
  var host: String {
    switch self {
    case .image:
      return "image.tmdb.org"
    default:
      return "api.themoviedb.org"
    }
  }
  
  var path: String {
    switch self {
    case .search:
      return "/3/search/movie/"
    case .fetch(let id):
      return "/3/movie/\(id)"
    case .image(let path):
      return "/t/p/w500/\(path)"
    }
  }
  
  var queryItems: [URLQueryItem] {
    switch self {
    case .search(let title):
      return [
        URLQueryItem(name: "api_key", value: apiKey),
        URLQueryItem(name: "language", value: "en"),
        URLQueryItem(name: "query", value: title),
        URLQueryItem(name: "page", value: "1"),
        URLQueryItem(name: "include_adult", value: "false")
      ]
    case .fetch:
      return [
        URLQueryItem(name: "api_key", value: apiKey)
      ]
    default:
      return []
    }
  }
    
  func makeRequest() -> URLRequest? {
    var components = URLComponents()
    components.host = host
    components.scheme = scheme
    components.path = path
    components.queryItems = queryItems.isEmpty ? nil : queryItems
    
    guard let url = components.url else { return nil }
    
    return URLRequest(url: url)
  }
}
