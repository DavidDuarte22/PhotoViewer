//
//  HomeRouter.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 06/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

protocol HomeRouterInterface {
  func navigateToPhotoDetail(photo: Photo)
  var viewController: UIViewController? { get set }
}

class HomeRouterImpl: HomeRouterInterface {
  
  weak var viewController: UIViewController?
  
  func navigateToPhotoDetail(photo: Photo) {
    viewController?.navigationController?.present(PhotoDetailModule.build(photo: photo, container: App.shared.dependencyContainer), animated: true)
  }
}
