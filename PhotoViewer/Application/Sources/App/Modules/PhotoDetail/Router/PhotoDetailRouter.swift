//
//  PhotoDetailRouter.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 07/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit


protocol PhotoDetailRouterInterface: AnyObject {
    var viewController: UIViewController? { get set }
}

class PhotoDetailRouterImpl: PhotoDetailRouterInterface {
    
    weak var viewController: UIViewController?
    
}
