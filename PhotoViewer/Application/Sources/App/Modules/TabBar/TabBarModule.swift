//
//  TabBarModule.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 09/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class TabBarModule {
  static func build(submodules:  TabBarRouterProtocol.submodules) -> UITabBarController {
    
    let tabs = TabBarRouterImpl.tabs(usingSubmodules: submodules)
    let tabBarController = TabBarController(tabs: tabs)
    
    return tabBarController
  }
}
