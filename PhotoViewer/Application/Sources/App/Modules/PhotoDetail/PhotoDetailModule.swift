//
//  PhotoDetailModule.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 07/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class PhotoDetailModule {
  static func build(photo: Photo) -> UIViewController {
    
    let presenter = PhotoDetailPresenterImpl(photo: photo)
    let router = PhotoDetailRouterImpl()
    let interactor = PhotoDetailInteractorImpl()
    let view = PhotoDetailViewImpl(presenter: presenter)
    
    presenter.photoDetailRouter = router
    presenter.photoDetailInteractor = interactor
    router.viewController = view
    
    return view
  }
}
