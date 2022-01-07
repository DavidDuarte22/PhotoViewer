//
//  UserDefaultsDependencies.swift
//  PhotoViewer
//
//  Created by David Duarte on 04/01/2022.
//

import Foundation

protocol UserDefaultsContainerFactory: UserDefaultsInteractorFactory {
    var userDefaultsInteractor: UserDefaultsInteractorInterface & UserDefaultsInteractorObsInterface { get }
}



// MARK: Dependency factories
protocol UserDefaultsInteractorFactory {
    func makeUserDefaultsInteractor() -> UserDefaultsInteractorInterface & UserDefaultsInteractorObsInterface
}


