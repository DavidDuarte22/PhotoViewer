//
//  FakeApiService.swift
//  PhotoViewerTests
//
//  Created by David Duarte on 10/12/2021.
//

import Foundation

final class MyFakeService: ApiServiceInterface {
  var baseUrl: String
  let token: String
  
  init(baseUrl: String, token: String) {
    self.baseUrl = baseUrl
    self.token = token
  }
  
  static var resultPhotos: Result<PhotosRequestDTO, HTTP.Error>?
  static var resultPhoto: Result<PhotoDTO, HTTP.Error>?
  
  let photoRequestDTO = PhotosRequestDTO(
    totalResults: 8000,
    page: 1,
    perPage: 15,
    photos: [
      PhotoDTO(id: 3408744, width: 3546, height: 2255, url: "https://www.pexels.com/photo/scenic-view-of-snow-capped-mountains-during-night-3408744/", photographer: "stein egil liland", photographerURL: "https://www.pexels.com/@therato", photographerID: 144244, avgColor: "#557088", src: .init(original: "https://images.pexels.com/photos/3408744/pexels-photo-3408744.jpeg", large2X: "https://images.pexels.com/photos/3408744/pexels-photo-3408744.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940", large: "https://images.pexels.com/photos/3408744/pexels-photo-3408744.jpeg?auto=compress&cs=tinysrgb&h=650&w=940", medium: "https://images.pexels.com/photos/3408744/pexels-photo-3408744.jpeg?auto=compress&cs=tinysrgb&h=350", small: "https://images.pexels.com/photos/3408744/pexels-photo-3408744.jpeg?auto=compress&cs=tinysrgb&h=130", portrait: "https://images.pexels.com/photos/3408744/pexels-photo-3408744.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800", landscape: "https://images.pexels.com/photos/3408744/pexels-photo-3408744.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200", tiny: "https://images.pexels.com/photos/3408744/pexels-photo-3408744.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"), liked: false)
    ],
    nextPage: "https://api.pexels.com/v1/search/?page=2&per_page=15&query=nature")
  
  func photos(page: Int, completionHandler: @escaping (Result<PhotosRequestDTO, HTTP.Error>) -> Void) {
    
    guard URL(string: self.baseUrl + "search?query=nature&page=\(page)") != nil else {
      completionHandler(.failure(.invalidRequest))
      return
    }
    
    if let result = MyFakeService.resultPhotos {
      switch result {
      case .success(let responseStruct):
        completionHandler(.success(responseStruct))
      case .failure(let error):
        completionHandler(.failure(error))
      }
    } else {
      // Default success
      completionHandler(.success(photoRequestDTO))
    }
  }
  
  
  func photo(byID: Int, completionHandler: @escaping (Result<PhotoDTO, HTTP.Error>) -> Void) {
    guard URL(string: self.baseUrl + "photos/\(byID)") != nil else {
      completionHandler(.failure(.invalidRequest))
      return
    }
    
    if let result = MyFakeService.resultPhoto {
      switch result {
      case .success(let responseStruct):
        completionHandler(.success(responseStruct))
      case .failure(let error):
        completionHandler(.failure(error))
      }
    } else {
      // Default success
      completionHandler(.success(photoRequestDTO.photos[0]))
    }
  }
}
