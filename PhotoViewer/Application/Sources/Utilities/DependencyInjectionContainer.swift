//
//  DependencyInjectionContainer.swift
//  PhotoViewer
//
//  Created by David Duarte on 26/12/2021.
//

protocol DependencyContainerInterface: LocalDataManagerFactory,
                                       UserDefaultsInteractorFactory,
                                       FavoritesRouterFactory,
                                       FavoritesInteractorFactory,
                                       FavoritesPresenterFactory
{
    // UserDefaults
    var localDataManager: LocalManagerDataInterface { get }
    var userDefaultsInteractor: UserDefaultsInteractorInterface & UserDefaultsInteractorObsInterface { get }
    // Favorites
    var favoritesRouter: FavoritesRouterInterface { get }
    var favoritesInteractor: FavoritesInteractorInterface { get }
    var favoritesPresenter: FavoritesPresenterInterface { get }
}

class DependencyContainer: DependencyContainerInterface {
    // UserDefaults
    lazy var localDataManager: LocalManagerDataInterface = LocalManagerData()
    lazy var userDefaultsInteractor: UserDefaultsInteractorInterface & UserDefaultsInteractorObsInterface = UserDefaultsInteractorImpl(dependencies: self)
    // Favorites
    lazy var favoritesRouter: FavoritesRouterInterface = FavoritesRouterImpl()
    lazy var favoritesInteractor: FavoritesInteractorInterface = FavoritesInteractorImpl(dependencies: self)
    lazy var favoritesPresenter: FavoritesPresenterInterface = FavoritesPresenterImpl(dependencies: self)
}

// MARK: Dependency factories
// UserDefaults
protocol LocalDataManagerFactory {
    func makeLocalDataManager() -> LocalManagerDataInterface
}
protocol UserDefaultsInteractorFactory {
    func makeUserDefaultsInteractor() -> UserDefaultsInteractorInterface & UserDefaultsInteractorObsInterface
}

//Favorites Module
protocol FavoritesRouterFactory {
    func makeFavoritesRouter() -> FavoritesRouterInterface
}
protocol FavoritesInteractorFactory {
    func makeFavoritesInteractor() -> FavoritesInteractorInterface
}
protocol FavoritesPresenterFactory {
    func makeFavoritesPresenter() -> FavoritesPresenterInterface
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
}
