//
//  ImageView.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 08/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

protocol ImageViewDelegate:AnyObject {
  func notifyPhotoLoaded()
}

class ImageView: UIImageView {
  weak var delegate: ImageViewDelegate?
  override var image: UIImage? {
    didSet {
      super.image = image
      delegate?.notifyPhotoLoaded()
    }
  }
  
  override var intrinsicContentSize: CGSize {
    
    if let myImage = self.image {
      let myImageWidth = myImage.size.width
      let myImageHeight = myImage.size.height
      let myViewWidth = self.frame.size.width
      
      let ratio = myViewWidth/myImageWidth
      let scaledHeight = myImageHeight * ratio
      
      return CGSize(width: myViewWidth, height: scaledHeight)
    }
    
    return CGSize(width: -1.0, height: -1.0)
  }
}


class ScaledHeightImageView: UIImageView {
  
  
  
}

