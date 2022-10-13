//
//  ServiceBuilder.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 06/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Services

final class ServiceBuilder: ServiceBuilderInterface {

  lazy var api: ApiServiceInterface = {
    /*
     TODO: Important - Move token to a secure place (Keychain)
     baseUrl: Could be move to UserDefaults to implement different urls for different environments (i.e. testing or development)
     */
      MyApiService(baseUrl: "https://api.pexels.com/v1/",
                   token: "563492ad6f91700001000001d36a44b513a54361980f97abc7b08bbc")
    }()
  
}
