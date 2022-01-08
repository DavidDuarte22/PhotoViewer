//
//  PhotoDetailInteractorTests.swift
//  PhotoViewerTests
//
//  Created by David Duarte on 06/01/2022.
//

import XCTest
import Services

class PhotoDetailInteractorTests: XCTestCase {
    
    var sut: PhotoDetailInteractorInterface?
    
    override func setUp() {
        super.setUp()
        let container = MockDependencyContainer()
        sut = PhotoDetailInteractorImpl(dependencies: container)
    }
    
    /// 3408744 ID: Already loaded in LocalManagerData.
    func testSetLikeToPhoto_OK() {
        if let result = sut?.setLikeToPhoto(photoId: 3408744) {
            XCTAssertFalse(result)
        } else {
            XCTFail()
        }
    }
    
    func testSetLikeToPhoto2_OK() {
        if let result = sut?.setLikeToPhoto(photoId: 9999) {
            XCTAssertTrue(result)
        } else {
            XCTFail()
        }
    }
    
    func testSetUnlikeToPhoto_OK() {
        let _ = sut?.setLikeToPhoto(photoId: 3408744)
        if let result = sut?.setLikeToPhoto(photoId: 3408744) {
            XCTAssertTrue(result)
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
