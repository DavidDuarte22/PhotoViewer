//
//  FavoritesModule.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 09/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class FavoritesModule {
    
    static func build(container: DependencyContainerInterface) -> UIViewController {
        var router = container.makeFavoritesRouter()
        let view = FavoritesViewImpl(dependencies: container)
        
        router.viewController = view
        
        container.makeFavoritesPresenter().setInteractorIDsObserver()
        
        return view
    }
}
