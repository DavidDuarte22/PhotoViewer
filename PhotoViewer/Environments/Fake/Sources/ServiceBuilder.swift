//
//  ServiceBuilder.swift
//  PhotoViewer
//
//  Created by David Duarte on 11/12/2021.
//

import Foundation

final class ServiceBuilder: ServiceBuilderInterface {
  
  lazy var api: ApiServiceInterface = {
    
    MyFakeService(baseUrl: "https://api.pexels.com/v1/",
                  token: "563492ad6f91700001000001d36a44b513a54361980f97abc7b08bbc")
  }()
  
}
