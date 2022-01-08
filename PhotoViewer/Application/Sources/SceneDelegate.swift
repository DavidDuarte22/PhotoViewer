//
//  SceneDelegate.swift
//  PhotoViewer
//
//  Created by David Duarte on 10/12/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let window = App.shared
      .instantiateRootTabBarController(into: UIWindow(windowScene: windowScene))
    
    self.window = window
    window.makeKeyAndVisible()
  }
}

