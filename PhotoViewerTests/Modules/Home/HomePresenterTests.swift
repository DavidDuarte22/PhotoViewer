//
//  HomePresenterTests.swift
//  PhotoViewerTests
//
//  Created by David Duarte on 11/12/2021.
//

import XCTest
@testable import PhotoViewer

class HomePresenterTests: XCTestCase {
  
  class MockHomeInteractor: HomeInteractorInterface {
    var photos: [Photo]?
    
    func fetchPhotos(page: Int, completionHandler: @escaping photosClosure) {
      if let photos = photos {
        completionHandler(.success(photos))
      } else {
        completionHandler(.failure(HTTP.Error.invalidResponse))
      }
    }
  }
  
  class MockHomeRouter: HomeRouterInterface {
    weak var viewController: UIViewController?
    
    var navigateCalled = 0
    func navigateToPhotoDetail(photo: Photo) {
      navigateCalled += 1
    }
  }
  
  var sup: HomePresenterInterface?
  var mockInteractor = MockHomeInteractor()
  var mockRouter = MockHomeRouter()
  
  var mockPhotos =  [
    Photo(id: 15286, width: 2500, height: 1667, originalImage: "https://images.pexels.com/photos/15286/pexels-photo.jpg", smallImage: "https://images.pexels.com/photos/15286/pexels-photo.jpg?auto=compress&cs=tinysrgb&h=350", photographer: "Luis del Río", liked: false),
    Photo(id: 624015, width: 4216, height: 2848, originalImage: "https://images.pexels.com/photos/624015/pexels-photo-624015.jpeg", smallImage: "https://images.pexels.com/photos/624015/pexels-photo-624015.jpeg?auto=compress&cs=tinysrgb&h=350", photographer: "Frans Van Heerden", liked: false),
    Photo(id: 572897, width: 6914, height: 4463, originalImage: "https://images.pexels.com/photos/572897/pexels-photo-572897.jpeg", smallImage: "https://images.pexels.com/photos/572897/pexels-photo-572897.jpeg?auto=compress&cs=tinysrgb&h=350", photographer: "eberhard grossgasteiger", liked: false)
  ]
  
  override func setUp() {
    super.setUp()
    sup = HomePresenterImpl(homeInteractor: mockInteractor, homeRouter: mockRouter)
  }
  
  override func tearDown() {
    sup = nil
    super.tearDown()
  }
  
  func testGetPhotoURL_OK() {
    sup?.photos.value = mockPhotos
    let url = sup?.getPhotoUrl(for: 0)
    XCTAssertNotNil(url)
  }
  
  func testGetPhotoURL_NotOK_invalidURL() {
    sup?.photos.value = [
      Photo(id: 15286, width: 2500, height: 1667, originalImage: "https://images.pexels.com/photos/15286/pexels-photo.jpg", smallImage: "fake url", photographer: "Luis del Río", liked: false)
    ]
    let url = sup?.getPhotoUrl(for: 0)
    XCTAssertNil(url)
  }
  
  func testGetPhotoURL_NotOK_invalidIndexPath() {
    sup?.photos.value = [
      Photo(id: 15286, width: 2500, height: 1667, originalImage: "https://images.pexels.com/photos/15286/pexels-photo.jpg", smallImage: "https://images.pexels.com/photos/15286/pexels-photo.jpg?auto=compress&cs=tinysrgb&h=350", photographer: "Luis del Río", liked: false)
    ]
    let url = sup?.getPhotoUrl(for: 1)
    XCTAssertNil(url)
  }
  
  func testFetchPhotos_OK() {
    mockInteractor.photos = mockPhotos
    sup?.fetchPhotos()

    XCTAssertNotNil(sup?.photos.value)
  }
  
  func testFetchPhotos_secondPage_OK() {
    mockInteractor.photos = [mockPhotos[0]]
    sup?.fetchPhotos()
    
    mockInteractor.photos = [mockPhotos[1]]
    sup?.fetchPhotos()
    
    XCTAssertEqual(sup?.photos.value?.count, 2)
    guard let photos = sup?.photos.value else { return XCTFail() }
    XCTAssertEqual(photos[0].id, 15286)
    XCTAssertEqual(photos[1].id, 624015)
  }
  
  func testFetchPhotos_emptyResult_OK() {
    mockInteractor.photos = []
    sup?.fetchPhotos()
    XCTAssertEqual(sup?.photos.value?.count, 0)
  }
  
  // TODO: Error handling not develop yet. To test: just avoid set a value to mockInteractor.photos
  func testFetchPhotos_NotOK() {
    //sup?.fetchPhotos()
    
  }
  
  func testDidSelectPhoto_OK() {
    mockInteractor.photos = mockPhotos
    sup?.fetchPhotos()
    sup?.didSelectPhoto(indexPath: IndexPath(row: 0, section: 0))
    XCTAssertEqual(mockRouter.navigateCalled, 1)
  }
  
  func testDidSelectPhoto_NotOK_invalidIndexPath() {
    mockInteractor.photos = mockPhotos
    sup?.fetchPhotos()
    sup?.didSelectPhoto(indexPath: IndexPath(row: 4, section: 0))
    XCTAssertEqual(mockRouter.navigateCalled, 0)
  }
  
  func testGetProportionallyHeight_OK() {
    let mockCollectionView = UICollectionView(frame: .init(origin: .zero, size: .init(width: 400, height: 400)), collectionViewLayout: .init())
    // width column is going to be the half of the total (2 columns) = 200
    let newHeight = sup?.getProportionallyHeight(collectionView: mockCollectionView, width: 200, height: 100)
    // and newHeight column width * height / width . 200 * 100 / 200
    XCTAssertEqual(100, newHeight)
  }
}
 
