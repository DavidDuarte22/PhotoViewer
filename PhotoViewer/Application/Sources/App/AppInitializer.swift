//
//  AppInitializer.swift
//  PhotoViewer
//
//  Created by David Duarte on 10/12/2021.
//

import Foundation
import UIKit

class AppInitializer {
  // Decorate window with TabBarModule
  func instantiateRootTabBarController(into window: UIWindow) -> UIWindow {
    let submodules = (
      home: HomeModule.build(),
      favorites: FavoritesModule.build()
    )
    
    window.rootViewController = UINavigationController(rootViewController: TabBarModule.build(submodules: submodules))
    return window
  }
}
