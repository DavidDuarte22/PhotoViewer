//
//  ServiceBuilder.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 06/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

final class ServiceBuilder: ServiceBuilderInterface {

    lazy var api: ApiServiceInterface = {
      MyApiService(baseUrl: "https://api.pexels.com/v1/",
                   token: "563492ad6f91700001000001d36a44b513a54361980f97abc7b08bbc")
    }()
  
}
