//
//  FavoritesModule.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 09/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class FavoritesModule {
  static func build() -> UIViewController {
    
    let presenter = FavoritesPresenterImpl()
    let router = FavoritesRouterImpl()
    let interactor = FavoritesInteractorImpl()
    let view = FavoritesViewImpl(presenter: presenter)
    
    presenter.favoritesRouter = router
    presenter.favoritesInteractor = interactor
    router.viewController = view
    
    presenter.setInteractorIDsObserver()
    
    return view
  }
}

