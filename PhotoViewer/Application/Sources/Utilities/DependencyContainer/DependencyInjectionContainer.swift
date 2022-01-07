//
//  DependencyInjectionContainer.swift
//  PhotoViewer
//
//  Created by David Duarte on 26/12/2021.
//

protocol DependencyContainerInterface: UserDefaultsContainerFactory,
                                       LocalDataManagerFactory,
                                       FavoritesContainerFactory,
                                       PhotoDetailContainerInterface
{ }

class DependencyContainer: DependencyContainerInterface {
    // UserDefaults
    lazy var localDataManager: LocalManagerDataInterface = LocalManagerData()
    lazy var userDefaultsInteractor: UserDefaultsInteractorInterface & UserDefaultsInteractorObsInterface = UserDefaultsInteractorImpl(dependencies: self)
    // Favorites
    lazy var favoritesRouter: FavoritesRouterInterface = FavoritesRouterImpl()
    lazy var favoritesInteractor: FavoritesInteractorInterface = FavoritesInteractorImpl(dependencies: self)
    lazy var favoritesPresenter: FavoritesPresenterInterface = FavoritesPresenterImpl(dependencies: self)
    // PhotoDetail
    lazy var photoDetailRouter: PhotoDetailRouterInterface = PhotoDetailRouterImpl()
    lazy var photoDetailInteractor: PhotoDetailInteractorInterface = PhotoDetailInteractorImpl(dependencies: self)
}

// MARK: Factories' extension
extension DependencyContainer {
    // UserDefaults
    func makeUserDefaultsInteractor() -> UserDefaultsInteractorInterface & UserDefaultsInteractorObsInterface {
        return userDefaultsInteractor
    }
    func makeLocalDataManager() -> LocalManagerDataInterface {
        return localDataManager
    }
    // Favorites Module
    func makeFavoritesRouter() -> FavoritesRouterInterface {
        return favoritesRouter
    }
    func makeFavoritesInteractor() -> FavoritesInteractorInterface {
        return favoritesInteractor
    }
    func makeFavoritesPresenter() -> FavoritesPresenterInterface {
        return favoritesPresenter
    }
    // PhotoDetail Module
    func makePhotoDetailRouter() -> PhotoDetailRouterInterface {
        return photoDetailRouter
    }
    func makePhotoDetailInteractor() -> PhotoDetailInteractorInterface {
        return photoDetailInteractor
    }
}
