//
//  Photo.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 06/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

struct Photo: Codable {
  let id: Int
  let width, height: Int
  let originalImage: String
  let smallImage: String
  let photographer: String
  var liked: Bool
}
