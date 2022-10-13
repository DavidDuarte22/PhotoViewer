//
//  ServiceBuilder.swift
//  PhotoViewer
//
//  Created by David Duarte on 11/12/2021.
//

import Foundation
import Services

final class ServiceBuilder: ServiceBuilderInterface {
  
  lazy var api: ApiServiceInterface = {
    
    /*
     TODO: If it's a fake Service the token shouldn't be necessary. Consider implement a Facade solution
     */
    MyFakeService(baseUrl: "https://api.pexels.com/v1/",
                  token: "563492ad6f91700001000001d36a44b513a54361980f97abc7b08bbc")
  }()
  
}
