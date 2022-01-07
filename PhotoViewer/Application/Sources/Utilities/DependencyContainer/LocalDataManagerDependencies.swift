//
//  LocalDataManagerDependencies.swift
//  PhotoViewer
//
//  Created by David Duarte on 07/01/2022.
//

import Foundation

protocol LocalDataManagerContainerFactory: LocalDataManagerFactory {
    var localDataManager: LocalManagerDataInterface { get }
}

protocol LocalDataManagerFactory {
    func makeLocalDataManager() -> LocalManagerDataInterface
}
