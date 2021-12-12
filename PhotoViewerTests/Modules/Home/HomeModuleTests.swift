//
//  HomeModuleTests.swift
//  PhotoViewerTests
//
//  Created by David Duarte on 11/12/2021.
//

import XCTest
@testable import PhotoViewer

class HomeModuleTests: XCTestCase {
    
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testHomeModuleInit_OK() {
    let moduleInstance = HomeModule.build()
    XCTAssertNotNil(moduleInstance)
  }
}
