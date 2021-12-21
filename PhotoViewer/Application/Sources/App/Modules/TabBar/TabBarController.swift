//
//  TabBarController.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 08/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

typealias tabBarTabs = (
  home: UIViewController,
  favorites: UIViewController
)

class TabBarController: UITabBarController, UITabBarControllerDelegate {
  
  required init(tabs: tabBarTabs) {
    super.init(nibName: nil, bundle: nil)
    viewControllers = [ tabs.home, tabs.favorites ]
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tabBar.tintColor = .lightGray
    self.tabBar.itemPositioning = .automatic
    
    self.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    self.selectedIndex = self.viewControllers?.count ?? 0
  }
}
