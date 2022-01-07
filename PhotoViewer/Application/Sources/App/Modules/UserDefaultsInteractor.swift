//
//  UserDefaultsInteractor.swift
//  PhotoViewer
//
//  Created by David Duarte on 24/12/2021.
//

import Foundation
import Services

protocol UserDefaultsInteractorInterface {
  func setLikeToPhoto(photoId: Int) -> Bool
}

protocol UserDefaultsInteractorObsInterface {
  func getFavoritesIDs()
  var favoritesID: Observable<[Int]> { get set }
}

class UserDefaultsInteractorImpl: UserDefaultsInteractorInterface, UserDefaultsInteractorObsInterface {
  typealias Dependencies = LocalDataManagerFactory
    
  init(dependencies: Dependencies){
    self.dependencies = dependencies
    var manager = dependencies.makeLocalDataManager()
    manager.delegate = self
  }
  
  private let dependencies: Dependencies
  var favoritesID = Observable<[Int]>([])

  func setLikeToPhoto(photoId: Int) -> Bool {
    return self.dependencies.makeLocalDataManager().addObject(into: .favoritesPhotos, id: photoId)
  }
  
  func getFavoritesIDs() {
    self.favoritesID.value = self.dependencies.makeLocalDataManager().getObjects(by: .favoritesPhotos)
  }
}

extension UserDefaultsInteractorImpl: LocalManagerDataDelegate {
  func keyChanged(key: DatasType, hasBeenAdded: Bool, id: Int) {
    if !hasBeenAdded {
      if let index = self.favoritesID.value.firstIndex(of: id) {
        self.favoritesID.value.remove(at: index)
      }
    } else {
      self.favoritesID.value.append(id)
    }
  }
}

