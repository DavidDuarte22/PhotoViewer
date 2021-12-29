//
//  ServiceInterface.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 06/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

protocol ApiServiceInterface {
  
  func photos(page: Int, completionHandler: @escaping (Result<PhotosRequestDTO, HTTP.Error>) -> Void)
  func photo(byID: Int, completionHandler: @escaping (Result<PhotoDTO, HTTP.Error>) -> Void)
  
}


enum HTTP {
  
  enum Method: String {
    case get
    //...
  }
  enum Error: LocalizedError {
    case invalidResponse
    case invalidRequest
    case statusCode(Int)
    case unknown(Swift.Error)
    case customMessage(String)
  }
}


final class MyApiService: ApiServiceInterface {
  let baseUrl: String
  let token: String
  
  init(baseUrl: String, token: String) {
    self.baseUrl = baseUrl
    self.token = token
  }
  
  func photos(page: Int, completionHandler: @escaping (Result<PhotosRequestDTO, HTTP.Error>) -> Void) {
    
    guard let url = URL(string: self.baseUrl + "search?query=nature&page=\(page)") else {
      completionHandler(.failure(.invalidRequest))
      return
    }
    
    privateRequest(url: url) { (response: Result<PhotosRequestDTO, HTTP.Error>) in
      switch response {
      case .success(let success):
        completionHandler(.success(success))
        
      case .failure(let failure):
        completionHandler(.failure(failure))
        
      }
    }
  }
  
  
  func photo(byID: Int, completionHandler: @escaping (Result<PhotoDTO, HTTP.Error>) -> Void) {
    guard let url = URL(string: self.baseUrl + "photos/\(byID)") else {
      completionHandler(.failure(.invalidRequest))
      return
    }
    
    privateRequest(url: url) { (response: Result<PhotoDTO, HTTP.Error>) in
      switch response {
      case .success(let success):
        completionHandler(.success(success))
        
      case .failure(let failure):
        completionHandler(.failure(failure))
        
      }
    }
  }
  
  
  private func privateRequest<T: Codable>(url: URL, completionHandler: @escaping (Result<T, HTTP.Error>) -> () ) {
    var request = URLRequest(url: url)
    request.setValue(self.token, forHTTPHeaderField: "Authorization")
    
    let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
      if let error = error {
        completionHandler(.failure(.unknown(error)))
      }
      
      if let data = data,
         let info = try? JSONDecoder().decode(T.self, from: data) {
        completionHandler(.success(info))
      } else {
        completionHandler(.failure(.invalidResponse))
      }
    })
    
    task.resume()
    
  }
}
