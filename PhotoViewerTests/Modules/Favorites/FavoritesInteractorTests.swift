//
//  FavoritesInteractorTests.swift
//  PhotoViewerTests
//
//  Created by David Duarte on 21/12/2021.
//

import XCTest
import Services
@testable import PhotoViewer

class FavoritesInteractorTests: XCTestCase {
    
    var sut: FavoritesInteractorInterface?
    
    override func setUp() {
        super.setUp()
        let container = MockDependencyContainer()
        
        sut = FavoritesInteractorImpl(dependencies: container)
    }
    
    override func tearDown() {
        MyFakeService.resultPhoto = nil
        super.tearDown()
    }
    
    func testGetFavoritesIDs_OK() {
        // getFavoritesIDs called in init
        XCTAssertEqual(sut?.favoritesID.value.count, 2)
    }
    
    func testFetchPhoto_OK() {
        let expectation = self.expectation(description: "Fetching")
        var result: Result<Photo, HTTP.Error>?
        
        sut?.fetchPhoto(by: 3408744) { response in
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
        
        sut?.fetchPhoto(by: 99) { response in
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
        if let result = sut?.setLikeToPhoto(photoId: 9999) {
            XCTAssertTrue(result)
        } else {
            XCTFail()
        }
    }
    
    /// 3408744 ID: Already loaded in MockLocalManagerData.
    func testSetLikeToPhoto2_OK() {
        if let result = sut?.setLikeToPhoto(photoId: 3408744) {
            XCTAssertFalse(result)
        } else {
            XCTFail()
        }
    }
    
    func testSetUnlikeToPhoto_OK() {
        if let result = sut?.setLikeToPhoto(photoId: 1) {
            XCTAssertFalse(result)
        } else {
            XCTFail()
        }
    }
    
    class MockDependencyContainer: UserDefaultsContainerFactory, LocalDataManagerFactory {
        
        lazy var localDataManager: LocalManagerDataInterface = MockLocalManagerData()
        lazy var userDefaultsInteractor: UserDefaultsInteractorInterface & UserDefaultsInteractorObsInterface = MockUserDefaultsInteractor(dependencies: self)
        
        
        func makeUserDefaultsInteractor() -> UserDefaultsInteractorInterface & UserDefaultsInteractorObsInterface {
            return userDefaultsInteractor
        }
        
        func makeLocalDataManager() -> LocalManagerDataInterface {
            return localDataManager
        }
    }
    
    
}
