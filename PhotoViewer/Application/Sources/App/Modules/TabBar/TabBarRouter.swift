//
//  TabBarRouter.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 08/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

protocol TabBarRouterProtocol {
  typealias submodules = (
    home: UIViewController,
    favorites: UIViewController
  )
}

class TabBarRouterImpl: TabBarRouterProtocol {
  
  weak var viewControllers: UIViewController?
  
  static func tabs(usingSubmodules submodules: submodules) -> tabBarTabs {
    let firstTabBarItem = UITabBarItem(title: "", image: .init(systemName: "house"), tag: 1)
    let secondTabBarItem = UITabBarItem(title: "", image: .init(systemName: "bookmark"), tag: 2)
    
    submodules.home.tabBarItem = firstTabBarItem
    submodules.favorites.tabBarItem = secondTabBarItem
    
    return (
      home: submodules.home,
      favorites: submodules.favorites
    )
  }
}
