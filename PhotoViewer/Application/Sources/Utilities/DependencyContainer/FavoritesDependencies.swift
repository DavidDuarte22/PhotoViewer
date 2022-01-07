//
//  FavoritesDependencies.swift
//  PhotoViewer
//
//  Created by David Duarte on 04/01/2022.
//

import Foundation

protocol FavoritesContainerFactory: FavoritesRouterFactory,
                                    FavoritesInteractorFactory,
                                    FavoritesPresenterFactory {
    // Favorites
    var favoritesRouter: FavoritesRouterInterface { get }
    var favoritesInteractor: FavoritesInteractorInterface { get }
    var favoritesPresenter: FavoritesPresenterInterface { get }
}

// MARK: Dependency factories
protocol FavoritesRouterFactory {
    func makeFavoritesRouter() -> FavoritesRouterInterface
}
protocol FavoritesInteractorFactory {
    func makeFavoritesInteractor() -> FavoritesInteractorInterface
}
protocol FavoritesPresenterFactory {
    func makeFavoritesPresenter() -> FavoritesPresenterInterface
}
