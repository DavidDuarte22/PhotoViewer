//
//  UserDefaultsInteractorTests.swift
//  PhotoViewerTests
//
//  Created by David Duarte on 06/01/2022.
//

import XCTest

class UserDefaultsInteractorTests: XCTestCase {

    var sup: UserDefaultsInteractorImpl?
    
    let mockContainer = MockDependencyContainer()
    
    override func setUp() {
        self.sup = UserDefaultsInteractorImpl(dependencies: mockContainer)
    }
    
    func testSetLikeToPhoto_OK() {
        if let result = sup?.setLikeToPhoto(photoId: 123) {
            XCTAssertTrue(result)
        } else {
            XCTFail()
        }
    }
    
    func testSetUnlikeToPhoto_OK() {
        sup?.getFavoritesIDs()
        if let result = sup?.setLikeToPhoto(photoId: 1) {
            XCTAssertFalse(result)
        } else {
            XCTFail()
        }
    }
    
    func testGetFavoritesIDs_OK() {
        guard let sup = sup else { return XCTFail() }
        sup.getFavoritesIDs()
        
        XCTAssertEqual(sup.favoritesID.value.count, 1)
    }
    
    class MockDependencyContainer: LocalDataManagerFactory {
        
        lazy var localDataManager: LocalManagerDataInterface = MockLocalManagerData()
        
        func makeLocalDataManager() -> LocalManagerDataInterface {
            return localDataManager
        }
    }
}
