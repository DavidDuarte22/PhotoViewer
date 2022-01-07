//
//  PhotoDetailPresenterTests.swift
//  PhotoViewerTests
//
//  Created by David Duarte on 03/01/2022.
//

import XCTest
import Services

class PhotoDetailPresenterTests: XCTestCase {
    
    var sup: PhotoDetailPresenterImpl?
    
    var mockPhoto: Photo!
    let mockContainer = MockDependencyContainer()
    
    override func setUp() {
        super.setUp()
        mockPhoto = Photo(id: 15286, width: 2500, height: 1000, originalImage: "https://images.pexels.com/photos/15286/pexels-photo.jpg", smallImage: "https://images.pexels.com/photos/15286/pexels-photo.jpg?auto=compress&cs=tinysrgb&h=350", photographer: "Luis del Río", liked: false)
        sup = PhotoDetailPresenterImpl(dependencies: mockContainer, photo: mockPhoto)
    }
    
    func testGetImageAspect_OK() {
        let mockImage = UIView(frame: .init(x: 0, y: 0, width: 250, height: 100))
        let aspectRatio = sup?.getImageAspect(view: mockImage)
       XCTAssertEqual(aspectRatio, 100)
    }
    
    func testLikePhoto_OK() {
        mockContainer.makePhotoDetailInteractor().mockPhoto = mockPhoto

        sup?.likePhoto()
        
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 1 seconds")], timeout: 1.0)

        XCTAssertEqual(sup?.photoItem.value.liked, true)
    }
    
    func testUnlikePhoto_OK() {
        mockContainer.makePhotoDetailInteractor().mockPhoto = mockPhoto

        sup?.likePhoto()
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 1 seconds")], timeout: 1.0)
        mockContainer.makePhotoDetailInteractor().mockPhoto.liked = ((sup?.photoItem.value.liked) != nil)
        sup?.likePhoto()
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 1 seconds")], timeout: 1.0)

        XCTAssertEqual(sup?.photoItem.value.liked, false)
    }
    
    
    class MockDependencyContainer: PhotoDetailRouterFactory,
                                   PhotoDetailInteractorFactory {
        
        lazy var photoDetailRouter = MockPhotoDetailRouter()
        lazy var photoDetailInteractor = MockPhotoDetailInteractor()
        
        func makePhotoDetailRouter() -> PhotoDetailRouterInterface {
            return photoDetailRouter
        }
        
        func makePhotoDetailInteractor() -> PhotoDetailInteractorInterface {
            return photoDetailInteractor
        }
    }
    
    class MockPhotoDetailRouter: PhotoDetailRouterInterface {
        func showErrorAlert(title: String, message: String, options: String...) {
            self.errorSpy += 1
        }
        
        var viewController: UIViewController?
    
    }
    
    class MockPhotoDetailInteractor: PhotoDetailInteractorInterface {
        
        func setLikeToPhoto(photoId: Int) -> Bool {
            if photoId == 15286 {
                if self.mockPhoto.liked {
                    return false
                } else {
                    return true
                }
            }
            XCTFail()
            return true
        }
    }
    
}


var IdentifiablePhotoKey = "kIdentifiablePhotoKey"
var IdentifiableErrorKey = "kIdentifiableErrorKey"

extension PhotoDetailInteractorInterface {
    var mockPhoto: Photo {
        get {
            return objc_getAssociatedObject(self, &IdentifiablePhotoKey) as? Photo ?? Photo(id: 0, width: 0, height: 0, originalImage: "", smallImage: "", photographer: "", liked: false)
        }
        set {
            objc_setAssociatedObject(self, &IdentifiablePhotoKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension PhotoDetailRouterInterface {
    var errorSpy: Int {
        get {
            return objc_getAssociatedObject(self, &IdentifiableErrorKey) as? Int ?? 0
        }
        set {
            objc_setAssociatedObject(self, &IdentifiableErrorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
