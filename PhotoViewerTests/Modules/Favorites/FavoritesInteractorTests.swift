//
//  FavoritesInteractorTests.swift
//  PhotoViewerTests
//
//  Created by David Duarte on 21/12/2021.
//

import XCTest
@testable import PhotoViewer

class FavoritesInteractorTests: XCTestCase {
  
  var sup: FavoritesInteractorInterface?
  
  override func setUp() {
    super.setUp()
    sup = FavoritesInteractorImpl(userDefaultsInteractor: MockUserDefaultsInteractor())
  }
  
  override func tearDown() {
    MyFakeService.resultPhoto = nil
    super.tearDown()
  }
  
  func testGetFavoritesIDs_OK() {
    // getFavoritesIDs called in init
    XCTAssertEqual(sup?.favoritesID.value.count, 1)
  }
  
  func testFetchPhoto_OK() {
    let expectation = self.expectation(description: "Fetching")
    var result: Result<Photo, HTTP.Error>?
    
    sup?.fetchPhoto(by: 3408744) { response in
      result = response
      expectation.fulfill()
    }

    waitForExpectations(timeout: 1, handler: nil)

    switch result {
    case .success(let responseObj):
      XCTAssertNotNil(responseObj)
    case .failure(_):
      XCTFail()
    case .none:
      XCTFail()
    }
  }
  
  func testFetchPhoto_NotOK() {
    MyFakeService.resultPhoto = .failure(.invalidResponse)
    let expectation = self.expectation(description: "Fetching")
    var result: Result<Photo, HTTP.Error>?
    
    sup?.fetchPhoto(by: 99) { response in
      result = response
      expectation.fulfill()
    }

    waitForExpectations(timeout: 1, handler: nil)

    switch result {
    case .success(_):
      XCTFail()
    case .failure(let error):
      XCTAssertNotNil(error)
    case .none:
      XCTFail()
    }
  }
  
  func testSetLikeToPhoto_OK() {
    let expectation = self.expectation(description: "Fetching")
    var result: Result<Bool, HTTP.Error>?
    
    sup?.setLikeToPhoto(photoId: 3408744) { response in
      result = response
      expectation.fulfill()
    }

    waitForExpectations(timeout: 1, handler: nil)

    switch result {
    case .success(let like):
      XCTAssertTrue(like)
    case .failure(_):
      XCTFail()
    case .none:
      XCTFail()
    }
  }
  
  func testSetUnlikeToPhoto_OK() {
    let expectation = self.expectation(description: "Fetching")
    var result: Result<Bool, HTTP.Error>?
    
    sup?.setLikeToPhoto(photoId: 1) { response in
      result = response
      expectation.fulfill()
    }

    waitForExpectations(timeout: 1, handler: nil)

    switch result {
    case .success(let like):
      XCTAssertFalse(like)
    case .failure(_):
      XCTFail()
    case .none:
      XCTFail()
    }
  }
  
  class MockUserDefaultsInteractor: UserDefaultsInteractorInterface, UserDefaultsInteractorObsInterface, LocalManagerDataDelegate {
    
    init() {
      userDefaultsManager.delegate = self
    }
    
    var favoritesID = Observable<[Int]>([])
    var userDefaultsManager = MockLocalManagerData()
    
    func setLikeToPhoto(photoId: Int, completionHandler: @escaping savedClosure) {
      let result = userDefaultsManager.addObject(into: .favoritesPhotos, id: photoId)
      completionHandler(.success(result))
    }
    
    func getFavoritesIDs() {
      self.favoritesID.value = userDefaultsManager.getObjects(by: .favoritesPhotos)
    }
    
    func keyChanged(key: DatasType, hasBeenAdded: Bool, id: Int) {
      if !hasBeenAdded {
        if let index = self.favoritesID.value.firstIndex(of: id) {
          self.favoritesID.value.remove(at: index)
        }
      } else {
        self.favoritesID.value.append(id)
      }
    }
  }
  
  class MockLocalManagerData: LocalManagerDataInterface {
    
    var defaults: UserDefaults?
    
    required init() {
      guard let defaults = UserDefaults(suiteName: "Fake") else { return }
      defaults.removePersistentDomain(forName: "Fake")
      self.defaults = defaults
      let _ = self.addObject(into: .favoritesPhotos, id: 1)
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
      defaults?.set(objectSaved, forKey: key.rawValue)
      delegate?.keyChanged(key: .favoritesPhotos, hasBeenAdded: added, id: id)
    }
    
    weak var delegate: LocalManagerDataDelegate?
    
    
    func getObjects(by key: DatasType) -> [Int] {
      return defaults?.object(forKey: key.rawValue) as? [Int] ?? [Int]()
    }
  }
}
