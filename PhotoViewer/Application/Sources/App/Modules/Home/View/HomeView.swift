//
//  HomeView.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 06/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class HomeViewImpl: UIViewController {
  
  let presenter: HomePresenterInterface
  var collectionView: UICollectionView?
  
  let cellIdentifier = "photoCell"
  
  required init(presenter: HomePresenterInterface) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.isNavigationBarHidden = true
    
    self.presenter.fetchPhotos()
    setViews()
    
    self.presenter.photos.bind { _ in
      DispatchQueue.main.async {
        // TODO: Only update the rows affected
        // add listener to check memory usage and stop adding cells
        self.collectionView?.reloadData()
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.isNavigationBarHidden = true
    
  }
  
  func setViews() {
    
    let layout = MosaicViewLayout()
    layout.delegate = self
    
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView?.backgroundColor = .black
    
    guard let collectionView = collectionView else {
      return
    }
    
    view.addSubview(collectionView)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: cellIdentifier)
    setupCollectionConstraints()
  }
  
  func setupCollectionConstraints() {
    guard let collectionView = collectionView else {
      return
    }
    
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
  }
  
}

// MARK: UICollectionViewDelegate
extension HomeViewImpl: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 20
  }
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.presenter.photos.value?.count ?? 0
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PhotoCell
    
    if let url = self.presenter.getPhotoUrl(for: indexPath.row) {
      cell.imageView.loadImage(at: url)
    }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    presenter.didSelectPhoto(indexPath: indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if indexPath.row == collectionView.numberOfItems(inSection: indexPath.section) - 1 {
      presenter.fetchPhotos()
    }
  }
}

// MARK: MosaicLayoutDelegate
extension HomeViewImpl: MosaicViewLayoutDelegate {
  
  func collectionView(_ collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat {
    if let photo = self.presenter.photos.value?[safe: indexPath.row] {
      return presenter.getProportionallyHeight(collectionView: collectionView, width: photo.width, height: photo.height)
    }
    return 0
  }
}
