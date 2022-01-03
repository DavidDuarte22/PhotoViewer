//
//  DependencyInjectionContainer.swift
//  PhotoViewer
//
//  Created by David Duarte on 26/12/2021.
//

protocol DependencyContainerInterface: LocalDataManagerFactory,
                                       UserDefaultsInteractorFactory  {
    var localDataManager: LocalManagerDataInterface { get }
    var userDefaultsInteractor: UserDefaultsInteractorInterface & UserDefaultsInteractorObsInterface { get }
}

class DependencyContainer: DependencyContainerInterface {
    
   lazy var localDataManager: LocalManagerDataInterface = LocalManagerData()
   lazy var userDefaultsInteractor: UserDefaultsInteractorInterface & UserDefaultsInteractorObsInterface = UserDefaultsInteractorImpl(dependencies: self)
}

// MARK: Dependency factories
protocol LocalDataManagerFactory {
  func makeLocalDataManager() -> LocalManagerDataInterface
}

protocol UserDefaultsInteractorFactory {
  func makeUserDefaultsInteractor() -> UserDefaultsInteractorInterface & UserDefaultsInteractorObsInterface
}

// MARK: Factories' extension
extension DependencyContainer {
  func makeUserDefaultsInteractor() -> UserDefaultsInteractorInterface & UserDefaultsInteractorObsInterface {
    return userDefaultsInteractor
  }
  
  func makeLocalDataManager() -> LocalManagerDataInterface {
    return localDataManager
  }
}
