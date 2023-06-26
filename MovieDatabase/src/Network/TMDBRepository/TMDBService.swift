//
//  TMDBService.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 23.06.2023.
//

import UIKit

class TMDBService: NetworkRouter, MovieRepository {
    
  // MARK: - Public (Properties)
  static let shared: MovieRepository = TMDBService()
  
  // MARK: - Init
  private override init() {
    super.init()
  }
  
  // MARK: - Private (Properties)
  private let jsonDecoder: JSONDecoder = {
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    return jsonDecoder
  }()
  
  // MARK: - MovieRepository
  func fetchMovie(
    with imdbID: String,
    successHandler: @escaping (_ response: Movie) -> (),
    errorHandler: @escaping(_ error: NetworkError) -> ()
  ) {
    sendRequest(with: TMDBEndpoint.fetch(imdbID)) { data in
      do {
        successHandler(try self.jsonDecoder.decode(Movie.self, from: data))
      } catch {
        errorHandler(.serializationError)
      }
    } errorHandler: { errorHandler($0) }
  }
  
  func searchMovie(
    with title: String,
    successHandler: @escaping (_ response: [Movie]) -> (),
    errorHandler: @escaping(_ error: NetworkError) -> ()
  ) {
    sendRequest(with: TMDBEndpoint.search(title)) { data in
      do {
        let searchResults = try self.jsonDecoder.decode(MovieSearchResults.self, from: data)
        successHandler(searchResults.results)
      } catch {
        errorHandler(.serializationError)
      }
    } errorHandler: { errorHandler($0) }
  }
  
  func fetchImage(
    path: String,
    successHandler: @escaping (UIImage) -> (),
    errorHandler: @escaping (NetworkError) -> ()
  ) {
    sendRequest(with: TMDBEndpoint.image(path)) { data in
      if let image = UIImage(data: data) {
        successHandler(image)
      } else {
        errorHandler(.serializationError)
      }
    } errorHandler: { errorHandler($0) }
  }
}
