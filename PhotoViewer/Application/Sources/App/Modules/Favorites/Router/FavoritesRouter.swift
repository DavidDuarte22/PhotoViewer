//
//  FavoritesRouter.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 09/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

protocol FavoritesRouterInterface {
  func showErrorAlert(title: String, message: String, options: String...)
}

class FavoritesRouterImpl: FavoritesRouterInterface {
  
  weak var viewController: UIViewController?
  
  func showErrorAlert(title: String, message: String, options: String...) {
    viewController?.presentAlertWithTitleAndMessage(title: title, message: message, options: options) { completion in
      
    }
  }
}
