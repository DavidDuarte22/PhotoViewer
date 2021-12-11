//
//  PhotoTests.swift
//  PhotoViewerTests
//
//  Created by David Duarte on 11/12/2021.
//

import XCTest
@testable import PhotoViewer

class PhotoTests: XCTestCase {
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
  }
  
  func testPhotoInit_OK() {
    let photo = Photo(id: 1, width: 100, height: 200, originalImage: "originalImage", smallImage: "smallImage", photographer: "photographer", liked: false)
    XCTAssertEqual(photo.id, 1)
    XCTAssertEqual(photo.width, 100)
    XCTAssertEqual(photo.height, 200)
    XCTAssertEqual(photo.originalImage, "originalImage")
    XCTAssertEqual(photo.smallImage, "smallImage")
    XCTAssertEqual(photo.photographer, "photographer")
    XCTAssertEqual(photo.liked, false)

  }
}
