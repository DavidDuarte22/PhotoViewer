//
//  UserDefaultsInteractorTests.swift
//  PhotoViewerTests
//
//  Created by David Duarte on 06/01/2022.
//

import XCTest

class UserDefaultsInteractorTests: XCTestCase {

    var sut: UserDefaultsInteractorImpl?
    
    let mockContainer = MockDependencyContainer()
    
    override func setUp() {
        self.sut = UserDefaultsInteractorImpl(dependencies: mockContainer)
    }
    
    func testSetLikeToPhoto_OK() {
        if let result = sut?.setLikeToPhoto(photoId: 123) {
            XCTAssertTrue(result)
        } else {
            XCTFail()
        }
    }
    
    func testSetUnlikeToPhoto_OK() {
        sut?.getFavoritesIDs()
        if let result = sut?.setLikeToPhoto(photoId: 1) {
            XCTAssertFalse(result)
        } else {
            XCTFail()
        }
    }
    
    func testGetFavoritesIDs_OK() {
        guard let sup = sut else { return XCTFail() }
        sup.getFavoritesIDs()
        
        XCTAssertEqual(sup.favoritesID.value.count, 2)
    }
    
    class MockDependencyContainer: LocalDataManagerFactory {
        
        lazy var localDataManager: LocalManagerDataInterface = MockLocalManagerData()
        
        func makeLocalDataManager() -> LocalManagerDataInterface {
            return localDataManager
        }
    }
}
