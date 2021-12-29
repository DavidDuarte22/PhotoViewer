//
//  MosaicViewLayout.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 06/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

protocol MosaicViewLayoutDelegate:AnyObject {
  func collectionView(_ collectionView: UICollectionView,
                      heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat
}

class MosaicViewLayout: UICollectionViewLayout {
  
  var numberOfColumns = 2
  var cachedIndex = 0
  
  weak var delegate: MosaicViewLayoutDelegate?
  
  fileprivate var cache = [UICollectionViewLayoutAttributes]()
  fileprivate var contentHeight: CGFloat = 0
  fileprivate var width: CGFloat {
    get {
      return collectionView!.bounds.width
    }
  }
  
  override var collectionViewContentSize : CGSize {
    return CGSize(width: width, height: contentHeight)
  }
  
  override func prepare() {
    
    guard let collectionView = collectionView else{
      return
    }
    // TODO: Cache doesn't work on refresh on demand. At the moment, is updating the entire collection, it's not optimized
    //    if cache.isEmpty {
    let columnWidth = (width - 20)  / CGFloat(numberOfColumns)
    
    var xOffsets = [CGFloat]()
    for column in 0..<numberOfColumns {
      xOffsets.append(CGFloat(column) * columnWidth)
    }
    
    var yOffsets = [CGFloat](repeating: 0, count: numberOfColumns)
    
    var column = 0
    for item in cachedIndex..<collectionView.numberOfItems(inSection: 0) {
      let indexPath = IndexPath(item: item, section: 0)
      let height = delegate?.collectionView(collectionView, heightForItemAtIndexPath: indexPath) ?? 0 + 10
      let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.frame = frame
      cache.append(attributes)
      contentHeight = max(contentHeight, frame.maxY)
      yOffsets[column] = yOffsets[column] + height
      column = column >= (numberOfColumns - 1) ? 0 : column + 1
    }
    //    }
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    for attributes in cache {
      if attributes.frame.intersects(rect) {
        layoutAttributes.append(attributes)
      }
    }
    return layoutAttributes
  }
}
