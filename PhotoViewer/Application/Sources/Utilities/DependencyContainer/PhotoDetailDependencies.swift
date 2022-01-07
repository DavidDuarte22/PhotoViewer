//
//  PhotoDetailDependencies.swift
//  PhotoViewer
//
//  Created by David Duarte on 04/01/2022.
//

import Foundation

protocol PhotoDetailContainerInterface: PhotoDetailRouterFactory,
                                        PhotoDetailInteractorFactory {
    // PhotoDetail
    var photoDetailRouter: PhotoDetailRouterInterface { get }
    var photoDetailInteractor: PhotoDetailInteractorInterface { get }
}

// MARK: Dependency factories
protocol PhotoDetailRouterFactory {
    func makePhotoDetailRouter() -> PhotoDetailRouterInterface
}
protocol PhotoDetailInteractorFactory {
    func makePhotoDetailInteractor() -> PhotoDetailInteractorInterface
}
