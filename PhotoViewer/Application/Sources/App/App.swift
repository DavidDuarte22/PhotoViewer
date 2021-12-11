//
//  ServiceInteractor.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 06/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

final class App {

    let services = ServiceBuilder()

    // MARK: - singleton

    static let shared = App()

    private init() {
        // do nothing...
    }
}
