//
//  HomeRouterTests.swift
//  PhotoViewerTests
//
//  Created by David Duarte on 12/12/2021.
//

import XCTest

class HomeRouterTests: XCTestCase {
  
  var sup: HomeRouterInterface?
  
  override func setUp() {
    super.setUp()
    sup = HomeRouterImpl()
  }
  
  let mockPhoto = Photo(id: 15286, width: 2500, height: 1667, originalImage: "https://images.pexels.com/photos/15286/pexels-photo.jpg", smallImage: "https://images.pexels.com/photos/15286/pexels-photo.jpg?auto=compress&cs=tinysrgb&h=350", photographer: "Luis del Río", liked: false)
  
  func testNavigateToPhotoDetail_OK() {
    sup?.navigateToPhotoDetail(photo: mockPhoto)
    let topNV = sup?.viewController?.navigationController
    XCTAssertTrue(topNV?.viewControllers.last is PhotoDetailViewImpl)
  }
}
