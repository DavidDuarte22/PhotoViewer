//
//  PhotoDetailInteractorTests.swift
//  PhotoViewerTests
//
//  Created by David Duarte on 06/01/2022.
//

import XCTest
import Services

class PhotoDetailInteractorTests: XCTestCase {
    
    var sup: PhotoDetailInteractorInterface?
    
    
    override func setUp() {
        super.setUp()
        let container = MockDependencyContainer()
        
        sup = PhotoDetailInteractorImpl(dependencies: container)
    }
    
    func testSetLikeToPhoto_OK() {
        if let result = sup?.setLikeToPhoto(photoId: 3408744) {
            XCTAssertTrue(result)
        } else {
            XCTFail()
        }
    }
    
    func testSetUnlikeToPhoto_OK() {
        let _ = sup?.setLikeToPhoto(photoId: 3408744)
        if let result = sup?.setLikeToPhoto(photoId: 3408744) {
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
