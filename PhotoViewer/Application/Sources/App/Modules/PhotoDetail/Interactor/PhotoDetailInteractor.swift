//
//  PhotoDetailInteractor.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 07/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Services

protocol PhotoDetailInteractorInterface: AnyObject {
    /// This function returns the new value of the photo.like.
    /// Could also return an error due it access to the db and could throws
    func setLikeToPhoto(photoId: Int) -> Bool
}

class PhotoDetailInteractorImpl: PhotoDetailInteractorInterface {
    
    typealias Dependencies = UserDefaultsInteractorFactory
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func setLikeToPhoto(photoId: Int) -> Bool {
        return self.dependencies.makeUserDefaultsInteractor().setLikeToPhoto(photoId: photoId)
    }
}
