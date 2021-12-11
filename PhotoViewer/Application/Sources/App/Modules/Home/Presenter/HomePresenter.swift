//
//  HomePresenter.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 06/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

protocol HomePresenterInterface {
  func fetchPhotos()
  var photos: Observable<[Photo]?> { get set }
  func getProportionallyHeight(collectionView: UICollectionView, width: Int, height: Int) -> CGFloat
  func didSelectPhoto(indexPath: IndexPath)
  func getPhotoUrl(for row: Int) -> URL?
}

class HomePresenterImpl: HomePresenterInterface {
  
  func getPhotoUrl(for row: Int) -> URL? {
    if let photo = photos.value?[row] {
      return URL(string: photo.smallImage)
    }
    return nil
  }
  
  
  var homeRouter: HomeRouterInterface?
  var homeInteractor: HomeInteractorInterface?

  private var page = 1
  
  var photos = Observable<[Photo]?>(nil)
  
  func fetchPhotos() {
    homeInteractor?.fetchPhotos(page: page) { [weak self] result in
      switch result {
      case .success(let photos):
        self?.page += 1
        guard let cachedPhotos = self?.photos.value else {
          self?.photos.value = photos
          return
        }
        self?.photos.value = cachedPhotos + photos
      case .failure(_):
        // TODO: navigate to error page
        break
      }
    }
  }
  
  func didSelectPhoto(indexPath: IndexPath) {
    guard let photo = self.photos.value?[indexPath.row] else { return }
    homeRouter?.navigateToPhotoDetail(photo: photo)
  }
  
  internal func getProportionallyHeight(collectionView: UICollectionView, width: Int, height: Int) -> CGFloat {
    let widthColumn = collectionView.bounds.width / 2
    let newHeight = CGFloat(widthColumn) * CGFloat(height) / CGFloat(width)
    return newHeight
  }
    
}

