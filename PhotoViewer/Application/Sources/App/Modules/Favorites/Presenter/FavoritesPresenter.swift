//
//  FavoritesPresenter.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 09/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

protocol FavoritesPresenterInterface {
    var favoritesPhotos: Observable<[Photo]?> { get set }
    func getPhotoUrl(for row: Int) -> URL?
    func likedPhoto(at indexPath: IndexPath)
    
    func tableViewRows() -> Int
    func setInteractorIDsObserver()
}

class FavoritesPresenterImpl: FavoritesPresenterInterface {
    
    var favoritesPhotos = Observable<[Photo]?>(nil)
    var photosIDs = [Int]()
    
    typealias Dependencies = FavoritesRouterFactory & FavoritesInteractorFactory
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    private func getFavoritesPhotos() {
        
        var photosArray = [Photo]()
        let dispatchGroup = DispatchGroup()
        
        for photoID in photosIDs {
            dispatchGroup.enter()
            
            self.getPhotoByID(photoID: photoID) { photo in
                guard let photo = photo else { return dispatchGroup.leave() }
                photosArray.append(photo)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.favoritesPhotos.value = photosArray
        }
    }
    
    func getPhotoByID(photoID: Int,
                      completionHandler: @escaping (Photo?) -> Void ) {
        self.dependencies.makeFavoritesInteractor().fetchPhoto(by: photoID) {  result in
            switch result {
            case .success(let photo):
                completionHandler(photo)
                break
            case .failure(_):
                // TODO
                completionHandler(nil)
                break
            }
        }
    }
}

//
// MARK: View's methods
//
extension FavoritesPresenterImpl {
    func setInteractorIDsObserver() {
        self.dependencies.makeFavoritesInteractor().favoritesID.bind { [weak self] ids in
            self?.photosIDs = ids
            self?.getFavoritesPhotos()
        }
    }
    
    func tableViewRows() -> Int {
        if let photosCount = self.favoritesPhotos.value?.count,
           photosCount > 0
        {
            return photosCount
        } else {
            return 0
        }
    }
    
    func getPhotoUrl(for row: Int) -> URL? {
        if let photo = favoritesPhotos.value?[safe: row] {
            return URL(string: photo.smallImage)
        }
        return nil
    }
    
    func likedPhoto(at indexPath: IndexPath) {
        guard let photoID = self.favoritesPhotos.value?[safe: indexPath.row]?.id else { return }
        self.dependencies.makeFavoritesInteractor().setLikeToPhoto(photoId: photoID) { [weak self] result in
            switch result {
            case .success(let isLiked):
                if !isLiked {
                    self?.favoritesPhotos.value?.remove(at: indexPath.row)
                }
                self?.getFavoritesPhotos()
            case .failure(let error):
                self?.dependencies.makeFavoritesRouter().showErrorAlert(title: "Something went wrong :(", message: error.localizedDescription, options: "OK")
            }
        }
    }
}
