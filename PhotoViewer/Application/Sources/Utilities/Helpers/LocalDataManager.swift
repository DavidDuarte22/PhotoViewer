//
//  LocalDataManager.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 09/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

protocol LocalManagerDataDelegate:AnyObject {
  func keyChanged(key: DatasType, hasBeenAdded: Bool, id: Int)
}

protocol LocalManagerDataInterface {
  func addObject(into key: DatasType, id: Int) -> Bool
  func setKey(into key: DatasType, id: Int, objectSaved: [Int], added: Bool)
  func getObjects(by key: DatasType) -> [Int]
  
  var delegate: LocalManagerDataDelegate? { get set }
}

class LocalManagerData: LocalManagerDataInterface {
  
  weak var delegate: LocalManagerDataDelegate?

  let defaults = UserDefaults.standard
  
  func getObjects(by key: DatasType) -> [Int] {
    return defaults.object(forKey: key.rawValue) as? [Int] ?? [Int]()
  }
  
  func addObject(into key: DatasType, id: Int) -> Bool {
    
    var objectSaved = getObjects(by: key)

    if let index = objectSaved.firstIndex(of: id) {
      objectSaved.remove(at: index)
      setKey(into: .favoritesPhotos, id: id, objectSaved: objectSaved, added: false)
      return false
    } else {
      objectSaved.append(id)
      setKey(into: .favoritesPhotos, id: id, objectSaved: objectSaved, added: true)
      return true
    }
  }
  
  func setKey(into key: DatasType, id: Int, objectSaved: [Int], added: Bool) {
    defaults.set(objectSaved, forKey: key.rawValue)
    delegate?.keyChanged(key: .favoritesPhotos, hasBeenAdded: added, id: id)
  }
}

enum DatasType: String {
  case favoritesPhotos
}
