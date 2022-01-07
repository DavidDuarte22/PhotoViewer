//
//  PhotoDetailModule.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 07/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class PhotoDetailModule {
    static func build(photo: Photo, container: DependencyContainer) -> UIViewController {
        
        var router = container.makePhotoDetailRouter()
        let presenter = PhotoDetailPresenterImpl(dependencies: container, photo: photo)
        let view = PhotoDetailViewImpl(presenter: presenter)
        
        router.viewController = view
        
        return view
    }
}
