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
    
    let router = HomeRouterImpl()
    let interactor = HomeInteractorImpl()
    let presenter = HomePresenterImpl(homeInteractor: interactor, homeRouter: router)
    let view = HomeViewImpl(presenter: presenter)
    
    router.viewController = view
    
    return view
  }
}
