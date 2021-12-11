//
//  FavoritesInteractor.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 09/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

protocol FavoritesInteractorInterface {
  func setLikeToPhoto(photoId: Int, completionHandler: @escaping savedClosure)
  func fetchPhoto(by id: Int, completionHandler: @escaping photoClosure)
  
  var favoritesID: Observable<[Int]> { get set }
  
  typealias photoClosure = (Result<Photo, HTTP.Error>) -> Void
  typealias savedClosure = (Result<Bool, HTTP.Error>) -> Void
}

class FavoritesInteractorImpl: FavoritesInteractorInterface {
  
  var favoritesID = Observable<[Int]>([])
  let userDefaultsManager = LocalManagerData.shared

  let services: ServiceBuilderInterface
  
  init(services: ServiceBuilderInterface = App.shared.services) {
    self.services = services
    LocalManagerData.shared.delegate = self
    getFavoritesIDs()
  }
  
  private func getFavoritesIDs() {
    self.favoritesID.value = LocalManagerData.shared.getObjects(by: .favoritesPhotos)
  }
  
  func fetchPhoto(by id: Int, completionHandler: @escaping photoClosure) {
    self.services.api.photo(byID: id) { result in
      switch result {
      case .success(let photoDTO):
        let photo = HomeInteractorImpl.parsePhotoDTO(photoDTO: photoDTO)
        completionHandler(.success(photo))
      case .failure(let error):
        completionHandler(.failure(error))
      }
    }
  }
  
  func setLikeToPhoto(photoId: Int, completionHandler: @escaping savedClosure) {
    // TODO: Duplicated code. Unify
    let result = userDefaultsManager.addObject(into: .favoritesPhotos, id: photoId)
    completionHandler(.success(result))
  }
}

extension FavoritesInteractorImpl: LocalManagerDataDelegate {
  func keyChanged(key: LocalManagerData.DatasType, hasBeenAdded: Bool, id: Int) {
    if !hasBeenAdded {
      if let index = self.favoritesID.value.firstIndex(of: id) {
        self.favoritesID.value.remove(at: index)
      }
    } else {
      self.favoritesID.value.append(id)
    }
  }
}
