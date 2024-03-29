//
//  FavoritesRouter.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 09/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

protocol FavoritesRouterInterface {
    func showErrorAlert(title: String, message: String, options: String...)
    var viewController: UIViewController? { get set }
}

class FavoritesRouterImpl: FavoritesRouterInterface {
    
    weak var viewController: UIViewController?
    
    func showErrorAlert(title: String, message: String, options: String...) {
      /*
       TODO: Isn't ok to show the alert at the Router even if it have the VC instance 
       */
        DispatchQueue.main.async {
            self.viewController?.presentAlertWithTitleAndMessage(title: title, message: message, options: options) { completion in
            
            }
        }
    }
}
