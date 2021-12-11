//
//  UiimageView+Extension.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 07/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

extension UIImageView {
  func loadImage(at url: URL) {
    UIImageLoaderHelper.loader.load(url, for: self)
  }

  func cancelImageLoad() {
    UIImageLoaderHelper.loader.cancel(for: self)
  }
}


