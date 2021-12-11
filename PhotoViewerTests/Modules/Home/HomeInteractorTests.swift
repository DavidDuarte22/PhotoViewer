//
//  HomeInteractorTests.swift
//  PhotoViewerTests
//
//  Created by David Duarte on 10/12/2021.
//

import XCTest
@testable import PhotoViewer

class HomeInteractorTests: XCTestCase {
  
  var sup = HomeInteractorImpl(services: App.shared.services)
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    MyFakeService.resultPhotos = nil
    MyFakeService.resultPhoto = nil
    super.tearDown()
  }
  
  func testGetHomePhotos_OK() {
    let expectation = self.expectation(description: "Fetching")
    var result: Result<[Photo], HTTP.Error>?
    
    sup.fetchPhotos(page: 1) { response in
      result = response
      expectation.fulfill()
    }

    waitForExpectations(timeout: 5, handler: nil)

    switch result {
    case .success(let responseObj):
      XCTAssertNotNil(responseObj)
    case .failure(_):
      XCTFail()
    case .none:
      XCTFail()
    }
  }
  
  // TODO: Fullfill with different errors. Get API doc and update Service enum
  func testGetHomePhotos_NotOK() {
    let expectation = self.expectation(description: "Fetching")
    MyFakeService.resultPhotos = .failure(.invalidResponse)
    
    var result: Result<[Photo], HTTP.Error>?
    sup.fetchPhotos(page: 1) { response in
      result = response
      expectation.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
    
    switch result {
    case .success(_):
      XCTFail()
    case .failure(let error):
      XCTAssertNotNil(error)
    case .none:
      XCTFail()
    }
  }
  
  // TODO: DI to change self.baseURL or receive path by param.
  func testGetHomePhotos_UrlNotOK(){
    
  }
}
