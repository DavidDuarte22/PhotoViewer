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
    
    typealias Dependencies = PhotoDetailRouterFactory & PhotoDetailInteractorFactory
    
    var dependencies: Dependencies
    var photoItem: Observable<Photo>
    
    required init(dependencies: Dependencies, photo: Photo){
        self.dependencies = dependencies
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
    
    // TODO: Handle else and failure cases
    func likePhoto() {
        self.photoItem.value.liked = self.dependencies.makePhotoDetailInteractor().setLikeToPhoto(photoId: photoItem.value.id)
    }
}
