//
//  FavoritesInteractor.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 09/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Services

protocol FavoritesInteractorInterface: AnyObject {
  func setLikeToPhoto(photoId: Int) -> Bool
  func fetchPhoto(by id: Int, completionHandler: @escaping photoClosure)
  
  var favoritesID: Observable<[Int]> { get set }
  
  typealias photoClosure = (Result<Photo, HTTP.Error>) -> Void
  typealias savedClosure = (Result<Bool, HTTP.Error>) -> Void
}

class FavoritesInteractorImpl: FavoritesInteractorInterface {
  
  typealias Dependencies = UserDefaultsInteractorFactory
  
  let dependencies: Dependencies
  let services: ServiceBuilderInterface = App.shared.services
  var favoritesID = Observable<[Int]>([])
  
  init(dependencies: Dependencies) {
    self.dependencies = dependencies

    self.dependencies.makeUserDefaultsInteractor().favoritesID.bind { favorites in
      self.favoritesID.value = favorites
    }
    
    getFavoritesIDs()

  }
  
  private func getFavoritesIDs() {
    self.dependencies.makeUserDefaultsInteractor().getFavoritesIDs()
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
  
  func setLikeToPhoto(photoId: Int) -> Bool {
    return self.dependencies.makeUserDefaultsInteractor().setLikeToPhoto(photoId: photoId)
  }
}
