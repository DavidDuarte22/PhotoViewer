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
    
  let userDefaultsManager = LocalManagerData.shared
  
  func setLikeToPhoto(photoId: Int, completionHandler: @escaping savedClosure) {
    // TODO: Duplicated code. Unify
    let result = userDefaultsManager.addObject(into: .favoritesPhotos, id: photoId)
    completionHandler(.success(result))
  }
}
