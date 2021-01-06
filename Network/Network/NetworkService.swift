//
//  NetworkService.swift
//  Network
//
//  Created by Ireneusz Solek on 04/01/2020.
//  Copyright © 2020 Ireneusz Solek. All rights reserved.
//

import Foundation

public enum Result<T>{
  case success(T)
  case error(Error)
}


public protocol NetworkService {
  func get<T: Decodable>(url: URL, result: @escaping (Result<T>) -> ())
}

enum NetworkError: Error {
  case httpErrorWithCode(Int)
  case unableToDecodeJSON
  case networkError(Error)
  case other
  case emptyResponse
}

public final class URLSessionNetworkService: NetworkService {
  public init() {}
  
  public func get<T: Decodable>(url: URL, result: @escaping (Result<T>) -> ()) {
    let session = URLSession.shared
    let task = session.dataTask(with: url) { (data, response, error) in
      if let error = error {
        result(.error(error))
        return
      }
      guard let response = response as? HTTPURLResponse else {
        result(.error(NetworkError.other))
        return
      }
      guard (200...299).contains(response.statusCode) else {
        result(.error(NetworkError.httpErrorWithCode(response.statusCode)))
        return
      }
      guard let data = data else {
        result(.error(NetworkError.emptyResponse))
        return
      }
      guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
        result(.error(NetworkError.unableToDecodeJSON))
        return
      }
      result(.success(decoded))
    }
    task.resume()
  }
}

