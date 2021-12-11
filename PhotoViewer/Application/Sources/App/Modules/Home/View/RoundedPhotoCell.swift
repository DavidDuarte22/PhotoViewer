//
//  RoundedPhotoCell.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 06/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
  
  var photo: Photo?
  
  override init(frame: CGRect) {
    imageView.frame = frame
    super.init(frame: frame)
    addViews()
  }
  
  
  var imageView: UIImageView = {
    var imView = UIImageView()
    imView.layer.cornerRadius = 15.0
    imView.clipsToBounds = true
    return imView
  }()
  
  
  func addViews() {
    addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
    imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
    imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var onReuse: () -> Void = {}
  
  override func prepareForReuse() {
    imageView.image = nil
    imageView.cancelImageLoad()
  }
}


