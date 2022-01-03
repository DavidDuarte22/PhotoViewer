//
//  UIImageLoaderHelper.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 07/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

// MARK: UIImageHelper. Manages the loading for all UIImageView instances
/*
  have a dictionary of [UIImageView: UUID] to keep track of currently active image loading tasks.
  We map these based on the UIImageView so we can connect individual task identifiers to UIImageView instances.
 */

import UIKit
import Services

class UIImageLoaderHelper {
  static let loader = UIImageLoaderHelper()

  private let imageLoader = ImageLoader()
  private var uuidMap = [UIImageView: UUID]()

  private init() {}

  func load(_ url: URL, for imageView: UIImageView) {

    let token = imageLoader.loadImage(url) { result in

      defer { self.uuidMap.removeValue(forKey: imageView) }
      do {

        let image = try result.get()
        DispatchQueue.main.async {
          imageView.image = image
        }
      } catch {
        // handle the error
      }
    }

    if let token = token {
      uuidMap[imageView] = token
    }
  }

  func cancel(for imageView: UIImageView) {
    if let uuid = uuidMap[imageView] {
      imageLoader.cancelLoad(uuid)
      uuidMap.removeValue(forKey: imageView)
    }
  }
}
