//
//  IntegrationTests.swift
//  PhotoViewerTests
//
//  Created by David Duarte on 08/01/2022.
//

import XCTest
import Services

class FavoritesIntegrationTests: XCTestCase {

    var presenterSut: FavoritesPresenterInterface?
    var routerSut: FavoritesRouterInterface?
    var interactorSut: FavoritesInteractorInterface?
    
    let mockContainer = MockDependencyContainer()

    override func setUp() {
        super.setUp()

        self.presenterSut = mockContainer.makeFavoritesPresenter()
        self.routerSut = mockContainer.makeFavoritesRouter()
        self.interactorSut = mockContainer.makeFavoritesInteractor()
    }
    
    /// In MockDataManager we have 1 invalid ID and 1 valid ID (3408744 also in FakeService)
    func testGetFavoritesPhotos_OK() {
        
        presenterSut?.setInteractorIDsObserver()
        
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 2 seconds")], timeout: 1.0)
        
        XCTAssertEqual(presenterSut?.favoritesPhotos.value?.count, 1)
    }
    
    class MockDependencyContainer: FavoritesContainerFactory, UserDefaultsInteractorFactory, LocalDataManagerFactory {
        
        lazy var favoritesRouter: FavoritesRouterInterface = FavoritesRouterImpl()
        lazy var favoritesInteractor: FavoritesInteractorInterface = FavoritesInteractorImpl(dependencies: self)
        lazy var favoritesPresenter: FavoritesPresenterInterface = FavoritesPresenterImpl(dependencies: self)
        lazy var userDefaultsInteractor: UserDefaultsInteractorInterface & UserDefaultsInteractorObsInterface = MockUserDefaultsInteractor(dependencies: self)
        lazy var localDataManager: LocalManagerDataInterface = MockLocalManagerData()
        
        func makeFavoritesRouter() -> FavoritesRouterInterface {
            return favoritesRouter
        }
        
        func makeFavoritesInteractor() -> FavoritesInteractorInterface {
            return favoritesInteractor
        }
        
        func makeFavoritesPresenter() -> FavoritesPresenterInterface {
            return favoritesPresenter
        }
        
        func makeUserDefaultsInteractor() -> UserDefaultsInteractorInterface & UserDefaultsInteractorObsInterface {
            return userDefaultsInteractor
        }
        
        func makeLocalDataManager() -> LocalManagerDataInterface {
            return localDataManager
        }
    }
}
