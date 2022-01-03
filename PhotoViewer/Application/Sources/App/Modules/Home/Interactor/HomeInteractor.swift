//
//  HomeInteractor.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 06/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Services

protocol HomeInteractorInterface {
  func fetchPhotos(page: Int, completionHandler: @escaping photosClosure)
  
  typealias photosClosure = (Result<[Photo], HTTP.Error>) -> Void

}

class HomeInteractorImpl: HomeInteractorInterface {
  
  let services: ServiceBuilderInterface

  init(services: ServiceBuilderInterface = App.shared.services) {
      self.services = services
  }
  
  func fetchPhotos(page: Int, completionHandler: @escaping photosClosure) {
    self.services.api.photos(page: page) { [weak self] result in
      switch result {
      case .success(let photosDTO):
        guard let photos = self?.parsePhotosDTO(photosDTO: photosDTO) else { return }
        completionHandler(.success(photos))
      case .failure(let error):
        completionHandler(.failure(error))
      }
    }
  }
}

extension HomeInteractorImpl {
  func parsePhotosDTO(photosDTO: PhotosRequestDTO) -> [Photo] {
    var photos = [Photo]()
    for photoDTO in photosDTO.photos {
      photos.append(HomeInteractorImpl.parsePhotoDTO(photoDTO: photoDTO))
    }
    return photos
  }
  
  static func parsePhotoDTO(photoDTO: PhotoDTO) -> Photo {
    let photo = Photo(id: photoDTO.id,
                      width: photoDTO.width,
                      height: photoDTO.height,
                      originalImage: photoDTO.src.original,
                      smallImage: photoDTO.src.medium,
                      photographer: photoDTO.photographer,
                      liked: photoDTO.liked)
    return photo
  }
}
