//
//  DependencyInjectionContainer.swift
//  PhotoViewer
//
//  Created by David Duarte on 26/12/2021.
//

protocol LocalDataManagerFactory {
  func makeLocalDataManager() -> LocalManagerDataInterface
}

protocol UserDefaultsInteractorFactory {
  func makeUserDefaultsInteractor() -> UserDefaultsInteractorInterface & UserDefaultsInteractorObsInterface
}

class DependencyContainer {
  private lazy var localDataManager: LocalManagerDataInterface = LocalManagerData()
  private lazy var userDefaultsInteractor = UserDefaultsInteractorImpl(dependencies: self)
}

extension DependencyContainer: LocalDataManagerFactory,
                               UserDefaultsInteractorFactory {
  func makeUserDefaultsInteractor() -> UserDefaultsInteractorInterface & UserDefaultsInteractorObsInterface {
    return userDefaultsInteractor
  }
  
  func makeLocalDataManager() -> LocalManagerDataInterface {
    return localDataManager
  }
}
