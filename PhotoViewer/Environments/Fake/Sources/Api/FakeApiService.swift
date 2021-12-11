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
    totalResults: 100,
    page: 1,
    perPage: 5,
    photos: [
      PhotoDTO(id: 1, width: 100, height: 100, url: "fakeUrl", photographer: "Fake Photographer", photographerURL: "fakeUrl", photographerID: 1, avgColor: "fakeColor", src: .init(original: "fakeOriginalUrl", large2X: "fakeLarge2Url", large: "fakeLargeUrl", medium: "fakeMediumUrl", small: "fakeSmallUrl", portrait: "fakePortraitUrl", landscape: "fakeLandscape", tiny: "fakeTiny"), liked: false)
    ],
    nextPage: "fake link")
  
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
