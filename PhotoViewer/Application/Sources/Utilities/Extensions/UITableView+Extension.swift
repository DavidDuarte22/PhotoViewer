//
//  UITableView+Extension.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 09/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

extension UITableView {
  func setEmptyView(title: String, message: String) {
    let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
    
    setViews(title: title, message: message, emptyView: emptyView)
  }
  
  
  func restore() {
    self.backgroundView = nil
    self.separatorStyle = .singleLine
  }
  
  private func setViews(title: String, message: String, emptyView: UIView) {
    self.backgroundView = emptyView
    self.separatorStyle = .none
    
    let titleLabel = UILabel()
    titleLabel.textColor = UIColor.white
    titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
    titleLabel.text = title
    
    let messageLabel = UILabel()
    messageLabel.textColor = UIColor.lightGray
    messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
    messageLabel.text = message
    messageLabel.numberOfLines = 0
    messageLabel.textAlignment = .center
    
    [ titleLabel, messageLabel ].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      emptyView.addSubview($0)
    }
    
    setConstraints(titleLabel: titleLabel, messageLabel: messageLabel, emptyView: emptyView)
  }
  
  private func setConstraints(titleLabel: UILabel, messageLabel: UILabel, emptyView: UIView) {
    
    titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -40).isActive = true
    titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
    messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
    messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor).isActive = true
    messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor).isActive = true
    
  }
}
