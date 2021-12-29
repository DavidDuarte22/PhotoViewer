//
//  PhotoDetailInteractor.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 07/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

protocol PhotoDetailInteractorInterface {
  func setLikeToPhoto(photoId: Int, completionHandler: @escaping savedClosure)
  
  typealias savedClosure = (Result<Bool, HTTP.Error>) -> Void
}

class PhotoDetailInteractorImpl: PhotoDetailInteractorInterface {
  
  typealias Dependencies = UserDefaultsInteractorFactory
  
  let dependencies: Dependencies

  init(dependencies: Dependencies) {
    self.dependencies = dependencies
  }
  
  func setLikeToPhoto(photoId: Int, completionHandler: @escaping savedClosure) {
    self.dependencies.makeUserDefaultsInteractor().setLikeToPhoto(photoId: photoId, completionHandler: completionHandler)
  }
}
