//
//  HomeModule.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 06/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class HomeModule {
  static func build() -> UIViewController {
    
    let presenter = HomePresenterImpl()
    let router = HomeRouterImpl()
    let interactor = HomeInteractorImpl()
    let view = HomeViewImpl(presenter: presenter)
    
    presenter.homeRouter = router
    presenter.homeInteractor = interactor
    router.viewController = view
    
    return view
  }
}
