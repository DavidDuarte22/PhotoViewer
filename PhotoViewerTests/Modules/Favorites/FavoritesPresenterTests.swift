//
//  FavoritesPresenterTests.swift
//  PhotoViewerTests
//
//  Created by David Duarte on 10/12/2021.
//

import XCTest

class FavoritesPresenterTests: XCTestCase {
    
    var sut: FavoritesPresenterImpl?
    
    var mockPhotos = [Photo]()
    let mockContainer = MockDependencyContainer()

    override func setUp() {
        super.setUp()
        sut = FavoritesPresenterImpl(dependencies: mockContainer)
        mockPhotos = [
            Photo(id: 15286, width: 2500, height: 1667, originalImage: "https://images.pexels.com/photos/15286/pexels-photo.jpg", smallImage: "https://images.pexels.com/photos/15286/pexels-photo.jpg?auto=compress&cs=tinysrgb&h=350", photographer: "Luis del Río", liked: false),
            Photo(id: 624015, width: 4216, height: 2848, originalImage: "https://images.pexels.com/photos/624015/pexels-photo-624015.jpeg", smallImage: "https://images.pexels.com/photos/624015/pexels-photo-624015.jpeg?auto=compress&cs=tinysrgb&h=350", photographer: "Frans Van Heerden", liked: false),
            Photo(id: 572897, width: 6914, height: 4463, originalImage: "https://images.pexels.com/photos/572897/pexels-photo-572897.jpeg", smallImage: "https://images.pexels.com/photos/572897/pexels-photo-572897.jpeg?auto=compress&cs=tinysrgb&h=350", photographer: "eberhard grossgasteiger", liked: false),
            Photo(id: 9999, width: 999, height: 999, originalImage: "fake original url", smallImage: "fake small url", photographer: "fake photographer", liked: false)
        ]
    }
    
    override func tearDown() {
        sut = nil
        mockPhotos.removeAll()
        super.tearDown()
    }
    
    func testGetPhotoByID_OK() {
        mockContainer.makeFavoritesInteractor().mockPhotos = mockPhotos
        mockContainer.makeFavoritesInteractor().favoritesID.value = [15286, 624015, 572897]
        sut?.getPhotoByID(photoID: 15286) { result, error in
            guard let photo = result else {
                return XCTFail()
            }
            XCTAssertEqual(photo, self.mockPhotos[0])
        }
    }
    
    func testGetPhotoByID_NotOK() {
        mockContainer.makeFavoritesInteractor().mockPhotos = mockPhotos
        mockContainer.makeFavoritesInteractor().favoritesID.value = [15286, 624015, 572897]
        sut?.getPhotoByID(photoID: 1) { result, error in
            XCTAssertNil(result)
            XCTAssertNotNil(error)
        }
    }
    
    func testSetInteractorIDsObserver_OK() {
        mockContainer.makeFavoritesInteractor().mockPhotos = mockPhotos
        mockContainer.makeFavoritesInteractor().favoritesID.value = [15286, 624015, 572897]
        sut?.setInteractorIDsObserver()
        XCTAssertEqual(sut?.photosIDs.count, 3)
    }
    
    func testGetFavoritesPhotos_OK() {
        mockContainer.makeFavoritesInteractor().mockPhotos = mockPhotos
        mockContainer.makeFavoritesInteractor().favoritesID.value = [15286, 624015, 572897, 9999]
        sut?.setInteractorIDsObserver()
        
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 2 seconds")], timeout: 1.0)
        
        XCTAssertEqual(sut?.favoritesPhotos.value, mockPhotos)
    }
    
    func testGetFavoritesPhotos_NotOK_getPhotoByID_FailureClosure() {
        mockContainer.makeFavoritesInteractor().mockPhotos = mockPhotos
        // last id is incorrect and won't fetch that photo
        mockContainer.makeFavoritesInteractor().favoritesID.value = [15286, 624015, 572897, 0]
        sut?.setInteractorIDsObserver()
        
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 1 seconds")], timeout: 1.0)
        
        mockPhotos.removeLast()
        XCTAssertEqual(sut?.favoritesPhotos.value, mockPhotos)
    }
    
    func testGetFavoritesPhotos_NotOK_getPhotoByID_FailureClosure2() {
        mockContainer.makeFavoritesInteractor().mockPhotos = mockPhotos
        // first id is incorrect and won't fetch that photo
        mockContainer.makeFavoritesInteractor().favoritesID.value = [0, 624015, 572897, 9999]
        sut?.setInteractorIDsObserver()
        
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for n seconds")], timeout: 1.0)
        
        mockPhotos.remove(at: 0)
        XCTAssertEqual(sut?.favoritesPhotos.value, mockPhotos)
    }
    
    func testTableViewRows_OK() {
        mockContainer.makeFavoritesInteractor().mockPhotos = mockPhotos
        mockContainer.makeFavoritesInteractor().favoritesID.value = [15286, 624015, 572897]
        sut?.setInteractorIDsObserver()
        
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 1 seconds")], timeout: 1.0)
        
        let rowsCount = sut?.tableViewRows()
        XCTAssertEqual(rowsCount, 3)
        
    }
    
    func testTableViewRows_OK_Empty() {
        sut?.setInteractorIDsObserver()
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 1 seconds")], timeout: 1.0)
        
        let rowsCount = sut?.tableViewRows()
        
        XCTAssertEqual(rowsCount, 0)
    }
    
    func testTableViewRows_favoritesPhotosNotSetted() {
        let rowsCount = sut?.tableViewRows()
        XCTAssertEqual(rowsCount, 0)
    }
    
    func testGetPhotoUrl_OK() {
        mockContainer.makeFavoritesInteractor().mockPhotos = mockPhotos
        mockContainer.makeFavoritesInteractor().favoritesID.value = [15286, 624015, 572897]
        sut?.setInteractorIDsObserver()
        
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 1 seconds")], timeout: 1.0)
        
        let url = sut?.getPhotoUrl(for: 0)
        
        XCTAssertNotNil(url)
    }
    
    func testGetPhotoUrl_NotOK_IndexError() {
        mockContainer.makeFavoritesInteractor().mockPhotos = mockPhotos
        mockContainer.makeFavoritesInteractor().favoritesID.value = [15286, 624015, 572897]
        sut?.setInteractorIDsObserver()
        
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 1 seconds")], timeout: 1.0)
        
        let url = sut?.getPhotoUrl(for: 4)
        
        XCTAssertNil(url)
        
    }
    
    func testGetPhotoUrl_NotOK_URLError() {
        mockContainer.makeFavoritesInteractor().mockPhotos = mockPhotos
        mockContainer.makeFavoritesInteractor().favoritesID.value = [9999]
        sut?.setInteractorIDsObserver()
        
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 1 seconds")], timeout: 1.0)
        
        let url = sut?.getPhotoUrl(for: 0)
        
        XCTAssertNil(url)
        
    }
    
    func testLikeToPhoto_OK_BothScenarios() {
        mockContainer.makeFavoritesInteractor().mockPhotos = mockPhotos
        mockContainer.makeFavoritesInteractor().favoritesID.value = [15286, 624015, 572897]
        sut?.setInteractorIDsObserver()
        
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 1 seconds")], timeout: 1.0)
        
        sut?.likedPhoto(at: IndexPath.init(row: 0, section: 0))
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 1 seconds")], timeout: 1.0)
        
        XCTAssertEqual(sut?.favoritesPhotos.value?[0].liked, true)
        
        sut?.likedPhoto(at: IndexPath.init(row: 0, section: 0))
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 1 seconds")], timeout: 1.0)
        
        XCTAssertEqual(sut?.favoritesPhotos.value?[0].liked, false)
        
    }
    
    // Just check the return in else statement wrapping the Index. Shouldn't crash
    func testLikeToPhoto_NotOK_IndexError() {
        mockContainer.makeFavoritesInteractor().mockPhotos = mockPhotos
        mockContainer.makeFavoritesInteractor().favoritesID.value = [15286, 624015, 572897]
        sut?.setInteractorIDsObserver()
        
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 1 seconds")], timeout: 1.0)
        
        XCTAssertNoThrow(sut?.likedPhoto(at: IndexPath.init(row: 3, section: 0)))
        
    }
    
    //TODO:
    func testLikeToPhoto_NotOK_FailureClosure() {
        mockContainer.makeFavoritesInteractor().mockPhotos = mockPhotos
        mockContainer.makeFavoritesInteractor().favoritesID.value = [9999]
        sut?.setInteractorIDsObserver()
        
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 1 seconds")], timeout: 1.0)
        
        
        
    }
    
    class MockDependencyContainer: FavoritesInteractorFactory,
                                   FavoritesRouterFactory {
        
        lazy var favoritesInteractor = MockFavoritesInteractor()
        lazy var favoritesRouter = MockFavoritesRouter()
        
        func makeFavoritesInteractor() -> FavoritesInteractorInterface {
            return favoritesInteractor
        }
        
        func makeFavoritesRouter() -> FavoritesRouterInterface {
            return favoritesRouter
        }
    }
    
    class MockFavoritesInteractor: FavoritesInteractorInterface {
        func setLikeToPhoto(photoId: Int) -> Bool {
            switch photoId {
            case 15286:
                let liked = mockPhotos[0].liked
                mockPhotos[0].liked = !liked
                return !liked
            case 624015:
                let liked = mockPhotos[1].liked
                mockPhotos[1].liked = !liked
                return !liked
            case 572897:
                let liked = mockPhotos[2].liked
                mockPhotos[2].liked = !liked
                return !liked
            case 9999:
                // Use this ID to throw error. TODO: Define error for these cases
                XCTFail()
                return false
            default:
                XCTFail()
                return false
            }
        }
        
        func fetchPhoto(by id: Int, completionHandler: @escaping photoClosure) {
            switch id {
            case 15286:
                completionHandler(.success(mockPhotos[0]))
            case 624015:
                completionHandler(.success(mockPhotos[1]))
            case 572897:
                completionHandler(.success(mockPhotos[2]))
            case 9999:
                completionHandler(.success(mockPhotos[3]))
            default:
                completionHandler(.failure(.invalidResponse))
            }
        }
        
            var favoritesID = Observable<[Int]>([])
        
    }
    
    class MockFavoritesRouter: FavoritesRouterInterface {
        weak var viewController: UIViewController?
        
        func showErrorAlert(title: String, message: String, options: String...) {
            
        }
    }
}

var IdentifiableIdKey   = "kIdentifiablePhotosKey"

extension FavoritesInteractorInterface {
    var mockPhotos: [Photo] {
        get {
            return objc_getAssociatedObject(self, &IdentifiableIdKey) as? [Photo] ?? [Photo]()
        }
        set {
            objc_setAssociatedObject(self, &IdentifiableIdKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
