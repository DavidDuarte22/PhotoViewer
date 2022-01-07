//
//  PhotoDetailRouter.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 07/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit


protocol PhotoDetailRouterInterface: AnyObject {
    func showErrorAlert(title: String, message: String, options: String...)
    var viewController: UIViewController? { get set }
}

class PhotoDetailRouterImpl: PhotoDetailRouterInterface {
    
    weak var viewController: UIViewController?
    
    func showErrorAlert(title: String, message: String, options: String...) {
        viewController?.presentAlertWithTitleAndMessage(title: title, message: message, options: options) { completion in
            
        }
    }
}
