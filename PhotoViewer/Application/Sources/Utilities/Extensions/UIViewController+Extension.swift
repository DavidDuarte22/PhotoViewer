//
//  UIViewController+Extension.swift
//  PhotoViewer
//
//  Created by David Duarte on 29/12/2021.
//

import UIKit

extension UIViewController {
  /// Display message in prompt view
  ///
  /// — Parameters:
  /// — title: Title to display Alert
  /// — message: Pass string of content message
  /// — options: Pass multiple UIAlertAction title like “OK”,”Cancel” etc
  /// — completion: The block to execute after the presentation finishes.
  func presentAlertWithTitleAndMessage(title: String, message: String, options: [String], completion: @escaping (Int) -> Void) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    for (index, option) in options.enumerated() {
      alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
        completion(index)
      }))
    }
    topMostViewController()?.present(alertController, animated: true, completion: nil)
  }
  
  /// Get the top most view in the app
  /// — Returns: It returns current foreground UIViewcontroller
  func topMostViewController() -> UIViewController? {
    let scenes = UIApplication.shared.connectedScenes
    let windowScene = scenes.first as? UIWindowScene
    let window = windowScene?.windows.first
    
    
    if var topController = window?.rootViewController {
      
      while let presentedViewController = topController.presentedViewController {
        topController = presentedViewController
      }
      
      return topController
      
    } else {
      
      return nil
      
    }
  }
}
