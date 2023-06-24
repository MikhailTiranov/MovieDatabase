//
//  NetworkRouter.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 24.06.2023.
//

import Foundation

class NetworkRouter {
  
  // MARK: - Public (Interface)
  func sendRequest(
    with endpoint: Endpointable,
    successHandler: @escaping (_ response: Data) -> (),
    errorHandler: @escaping(_ error: NetworkError) -> ()
  ) {
    guard let request = endpoint.makeRequest() else {
      errorHandler(NetworkError.invalidEndpoint)
      return
    }
    
    URLSession.shared.dataTask(
      with: request
    ) { (data, response, error) in
      if error != nil {
        errorHandler(NetworkError.apiError)
        return
      }
      
      guard
        let httpResponse = response as? HTTPURLResponse,
        200..<300 ~= httpResponse.statusCode
      else {
        errorHandler(NetworkError.invalidResponse)
        return
      }
      
      guard let data else {
        errorHandler(NetworkError.noData)
        return
      }
      
      successHandler(data)
    }
    .resume()
  }
}
