//
//  PhotoDetailPresenter.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 07/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

protocol PhotoDetailPresenterInterface {
  var photoItem: Observable<Photo> { get set }
  func getPhotographer() -> String
  func getImageAspect(view: UIView) -> CGFloat
  func getPhotoUrl() -> URL?
  func likePhoto()
}

class PhotoDetailPresenterImpl: PhotoDetailPresenterInterface {
  
  var photoDetailRouter: PhotoDetailRouterInterface?
  var photoDetailInteractor: PhotoDetailInteractorInterface?
  
  var photoItem: Observable<Photo>
  
  required init(photo: Photo){
    photoItem = Observable<Photo>.init(photo)
  }
  
  func getPhotographer() -> String {
    return self.photoItem.value.photographer
  }
  
  func getPhotoUrl() -> URL? {
    return URL(string: self.photoItem.value.originalImage)
  }
  
  func getImageAspect(view: UIView) -> CGFloat {
    let width = view.bounds.width
    let newHeight = CGFloat(width) * CGFloat(self.photoItem.value.height) / CGFloat(self.photoItem.value.width)
    return newHeight
  }
  
  // TODO: Duplicated code. Move to abstract class
  func likePhoto() {
    self.photoDetailInteractor?.setLikeToPhoto(photoId: photoItem.value.id) { result in
      switch result {
      case .success(let isLiked):
        self.photoItem.value.liked = isLiked
      case .failure(_):
        // TODO
        break
      }
    }
  }
}
