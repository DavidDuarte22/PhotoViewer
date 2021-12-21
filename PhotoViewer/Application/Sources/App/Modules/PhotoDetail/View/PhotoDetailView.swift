//
//  PhotoDetailView.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 07/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class PhotoDetailViewImpl: UIViewController {
  
  let presenter: PhotoDetailPresenterInterface
  
  required init(presenter: PhotoDetailPresenterInterface) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    photographerLabel.text = self.presenter.getPhotographer()
    
    setUpViews()
    setupConstraints()
    
    self.presenter.photoItem.bind { [self] photo in
      let imageName: String = (photo.liked) ? "heart.fill" :  "heart"
      let image =  UIImage(systemName: imageName)
      self.likeButton.setImage(image, for: .normal)
    }
  }
  
  private var viewTranslation = CGPoint(x: 0, y: 0)

  //
  // MARK: View properties
  //
  
  var imageView: ImageView = {
    let imView = ImageView()
    imView.layer.cornerRadius = 15.0
    imView.clipsToBounds = true
    return imView
  }()
  
  var photographerLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.boldSystemFont(ofSize: 16.0)
    return label
  }()
  
  var cardContentView: UIView = {
    let cardView = UIView()
    cardView.layer.cornerRadius = 15.0
    return cardView
  }()
  
  let loadingIndicator: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    activityIndicator.hidesWhenStopped = true
    activityIndicator.startAnimating()
    return activityIndicator
  }()
  
  let likeButton: UIButton = {
    let button = UIButton()
    button.clipsToBounds = true
    button.contentMode = .scaleAspectFill
    let icon = UIImage(systemName: "heart")
    button.setImage(icon, for: .normal)
    button.tintColor = .white

    button.addTarget(self, action: #selector(likeImage), for: .touchUpInside)
    return button
  }()
  
  let closeButton: UIButton = {
    let button = UIButton()
    button.clipsToBounds = true
    button.contentMode = .scaleAspectFill
    let icon = UIImage(systemName: "xmark")
    button.setImage(icon, for: .normal)
    button.tintColor = .white
    button.addTarget(self, action: #selector(closeImage), for: .touchUpInside)
    return button
  }()
  
  func setUpViews() {
    
    view.addSubview(cardContentView)
    cardContentView.translatesAutoresizingMaskIntoConstraints = false
    
    cardContentView.heightAnchor.constraint(equalToConstant: self.presenter.getImageAspect(view: view) + photographerLabel.frame.height + 65).isActive = true
    cardContentView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    cardContentView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    cardContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
    [ imageView, photographerLabel, loadingIndicator, likeButton, closeButton ].forEach {
      cardContentView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    likeButton.isHidden = true
    closeButton.isHidden = true
    guard let url = presenter.getPhotoUrl() else { return }
    
    imageView.loadImage(at: url)
    imageView.delegate = self
    
    self.view.applyGradient(isVertical: true, colorArray: [
      UIColor(red: 0, green: 0, blue: 0, alpha: 0),
      UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    ])
    
    addClickToDismiss()
    
  }
  
  func setupConstraints() {
    
    loadingIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
    loadingIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
    
    imageView.heightAnchor.constraint(equalToConstant: self.presenter.getImageAspect(view: view)).isActive = true
    imageView.bottomAnchor.constraint(equalTo: photographerLabel.topAnchor, constant: -20).isActive = true
    imageView.leftAnchor.constraint(equalTo: cardContentView.leftAnchor).isActive = true
    imageView.rightAnchor.constraint(equalTo: cardContentView.rightAnchor).isActive = true
    
    photographerLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
    photographerLabel.bottomAnchor.constraint(equalTo: cardContentView.bottomAnchor, constant: -50).isActive = true
    
    likeButton.rightAnchor.constraint(equalTo: cardContentView.rightAnchor, constant: -10).isActive = true
    likeButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 30).isActive = true
    
    closeButton.rightAnchor.constraint(equalTo: cardContentView.leftAnchor, constant: 30).isActive = true
    closeButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 30).isActive = true
  }
  
  
  private func addClickToDismiss() {
    let dragGesture = UIPanGestureRecognizer(target: self, action:  #selector(dismissPresentedView(_:)))
    
    dragGesture.cancelsTouchesInView = false
    self.view.addGestureRecognizer(dragGesture)
  }
  
  //
  // MARK: Actions
  //
  
  @objc private func dismissPresentedView(_ sender: UIPanGestureRecognizer) {
    switch sender.state {
    case .changed:
      viewTranslation = sender.translation(in: view)
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
        self.view.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
      })
    case .ended:
      if viewTranslation.y < 200 {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
          self.view.transform = .identity
        })
      } else {
        dismiss(animated: true, completion: nil)
      }
    default:
      break
    }
  }
  
  @objc func likeImage(sender: UIButton!) {
    self.presenter.likePhoto()
  }
  
  @objc func closeImage(sender: UIButton!){
    dismiss(animated: true, completion: nil)
  }
}

extension PhotoDetailViewImpl: ImageViewDelegate {
  func notifyPhotoLoaded() {
    self.loadingIndicator.isHidden = true
    self.likeButton.isHidden = false
    self.closeButton.isHidden = false
  }
}
