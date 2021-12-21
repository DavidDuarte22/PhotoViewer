//
//  FavoritePhotoCell.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 09/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

protocol FavoritePhotoCellDelegate:AnyObject {
  func photoLiked(at cell: UITableViewCell)
}

class FavoritePhotoCell: UITableViewCell {
  // TODO: Create another viper module with its presenter to handle photoItem instance
  var photoItem: Photo?
  weak var delegate: FavoritePhotoCellDelegate?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.selectionStyle = .none
    addViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var photoImageView: ImageView = {
    let imageView = ImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    return imageView
  }()
  
  lazy var likeButton: UIButton = {
    var configuration = UIButton.Configuration.filled()
    configuration.contentInsets = .init(top: 20, leading: 15, bottom: 0, trailing: 0)
    configuration.image = UIImage(systemName: "heart.fill")
    let button = UIButton(configuration: configuration)
    button.tintColor = .clear
    return button
  }()
  
  func addViews() {
    photoImageView.translatesAutoresizingMaskIntoConstraints = false
    likeButton.translatesAutoresizingMaskIntoConstraints = false
    
    self.addSubview(photoImageView)
    contentView.addSubview(likeButton)
    
    likeButton.addTarget(self, action: #selector(photoLiked), for: .touchUpInside)

    setupConstraints()
  }
  
  func setupConstraints() {
    
    photoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    photoImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    photoImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    
  }
  
  @objc func photoLiked() {
    delegate?.photoLiked(at: self)
  }
}

