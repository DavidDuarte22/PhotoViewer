//
//  PhotoDetailIntegrationTests.swift
//  PhotoViewerTests
//
//  Created by David Duarte on 08/01/2022.
//

import XCTest
import Services

class PhotoDetailIntegrationTests: XCTestCase {

    
    var presenterSut: PhotoDetailPresenterInterface?
    var routerSut: PhotoDetailRouterInterface?
    var interactorSut: PhotoDetailInteractorInterface?
    
    let mockContainer = MockDependencyContainer()
    
    func testLikePhoto_OK() {
        presenterSut?.likePhoto()
        
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 1 seconds")], timeout: 1.0)

        XCTAssertEqual(presenterSut?.photoItem.value.liked, true)
    }

    override func setUp() {
        super.setUp()

        let mockPhoto = Photo(id: 15286, width: 2500, height: 1000, originalImage: "https://images.pexels.com/photos/15286/pexels-photo.jpg", smallImage: "https://images.pexels.com/photos/15286/pexels-photo.jpg?auto=compress&cs=tinysrgb&h=350", photographer: "Luis del Río", liked: false)
        
        self.presenterSut = PhotoDetailPresenterImpl(dependencies: mockContainer, photo: mockPhoto)
        self.routerSut = mockContainer.makePhotoDetailRouter()
        self.interactorSut = mockContainer.makePhotoDetailInteractor()
    }
    
    class MockDependencyContainer: PhotoDetailRouterFactory, PhotoDetailInteractorFactory, UserDefaultsInteractorFactory, LocalDataManagerFactory {
        
        lazy var photoDetailRouter: PhotoDetailRouterInterface = PhotoDetailRouterImpl()
        lazy var photoDetailInteractor: PhotoDetailInteractorInterface = PhotoDetailInteractorImpl(dependencies: self)
        lazy var userDefaultsInteractor: UserDefaultsInteractorInterface & UserDefaultsInteractorObsInterface = MockUserDefaultsInteractor(dependencies: self)
        lazy var localDataManager: LocalManagerDataInterface = MockLocalManagerData()
        
        func makePhotoDetailRouter() -> PhotoDetailRouterInterface {
            return photoDetailRouter
        }
        
        func makePhotoDetailInteractor() -> PhotoDetailInteractorInterface {
            return photoDetailInteractor
        }
        
        func makeUserDefaultsInteractor() -> UserDefaultsInteractorInterface & UserDefaultsInteractorObsInterface {
            return userDefaultsInteractor
        }
        
        func makeLocalDataManager() -> LocalManagerDataInterface {
            return localDataManager
        }
    }
}
