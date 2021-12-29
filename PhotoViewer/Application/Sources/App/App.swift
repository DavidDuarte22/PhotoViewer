//
//  ServiceInteractor.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 06/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

final class App {
  
  let services = ServiceBuilder()
  let dependencyContainer = DependencyContainer()
  // MARK: - singleton
  
  static let shared = App()
  
  private init() {
    // do nothing...
  }
  
  // Decorate window with TabBarModule
  func instantiateRootTabBarController(into window: UIWindow) -> UIWindow {
    let submodules = (
      home: HomeModule.build(),
      favorites: FavoritesModule.build(container: dependencyContainer)
    )
    
    window.rootViewController = UINavigationController(rootViewController: TabBarModule.build(submodules: submodules))
    return window
  }
}
