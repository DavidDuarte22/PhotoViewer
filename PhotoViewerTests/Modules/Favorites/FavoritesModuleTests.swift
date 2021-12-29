//
//  FavoritesModuleTests.swift
//  PhotoViewerTests
//
//  Created by David Duarte on 26/12/2021.
//

import XCTest
@testable import PhotoViewer

class FavoritesModuleTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testHomeModuleInit_OK() {
    let moduleInstance = FavoritesModule.build()
    XCTAssertNotNil(moduleInstance)
  }
}
