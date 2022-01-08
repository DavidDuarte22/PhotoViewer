//
//  FakeLocalManagerData.swift
//  PhotoViewerTests
//
//  Created by David Duarte on 06/01/2022.
//

import Foundation

class MockUserDefaultsInteractor: UserDefaultsInteractorInterface, UserDefaultsInteractorObsInterface, LocalManagerDataDelegate {
    
    typealias Dependencies = LocalDataManagerFactory
    
    init(dependencies: Dependencies){
        self.dependencies = dependencies
        var manager = dependencies.makeLocalDataManager()
        manager.delegate = self
    }
    
    
    var favoritesID = Observable<[Int]>([])
    private let dependencies: Dependencies
    
    func setLikeToPhoto(photoId: Int) -> Bool {
        return self.dependencies.makeLocalDataManager().addObject(into: .favoritesPhotos, id: photoId)
    }
    
    func getFavoritesIDs() {
        self.favoritesID.value = self.dependencies.makeLocalDataManager().getObjects(by: .favoritesPhotos)
    }
    
    func keyChanged(key: DatasType, hasBeenAdded: Bool, id: Int) {
        if !hasBeenAdded {
            if let index = self.favoritesID.value.firstIndex(of: id) {
                self.favoritesID.value.remove(at: index)
            }
        } else {
            self.favoritesID.value.append(id)
        }
    }
}

/// Loaded with just id 1. Use it for unlike a photo or get an already liked photo
class MockLocalManagerData: LocalManagerDataInterface {
    
    var defaults: UserDefaults?
    
    required init() {
        guard let defaults = UserDefaults(suiteName: "Fake") else { return }
        defaults.removePersistentDomain(forName: "Fake")
        self.defaults = defaults
        let _ = self.addObject(into: .favoritesPhotos, id: 1)
        let _ = self.addObject(into: .favoritesPhotos, id: 3408744)
    }
    
    func addObject(into key: DatasType, id: Int) -> Bool {
        var objectSaved = getObjects(by: key)
        
        if let index = objectSaved.firstIndex(of: id) {
            objectSaved.remove(at: index)
            setKey(into: .favoritesPhotos, id: id, objectSaved: objectSaved, added: false)
            return false
        } else {
            objectSaved.append(id)
            setKey(into: .favoritesPhotos, id: id, objectSaved: objectSaved, added: true)
            return true
        }
    }
    
    func setKey(into key: DatasType, id: Int, objectSaved: [Int], added: Bool) {
        defaults?.set(objectSaved, forKey: key.rawValue)
        delegate?.keyChanged(key: .favoritesPhotos, hasBeenAdded: added, id: id)
    }
    
    weak var delegate: LocalManagerDataDelegate?
    
    
    func getObjects(by key: DatasType) -> [Int] {
        return defaults?.object(forKey: key.rawValue) as? [Int] ?? [Int]()
    }
}
