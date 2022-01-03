//
//  FavoritesModule.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 09/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class FavoritesModule {
  
  static func build(container: DependencyContainerInterface) -> UIViewController {
    
    let router = FavoritesRouterImpl()
    let interactor = FavoritesInteractorImpl(dependencies: container)
    let presenter = FavoritesPresenterImpl(favoritesInteractor: interactor, favoritesRouter: router)
    let view = FavoritesViewImpl(presenter: presenter)
    
    router.viewController = view
    
    presenter.setInteractorIDsObserver()
    
    return view
  }
}
