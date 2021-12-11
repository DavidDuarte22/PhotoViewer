//
//  ImageLoader.swift
//  PhotoViewerApp_Example
//
//  Created by David Duarte on 07/12/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class ImageLoader {
  private var loadedImages = [URL: UIImage]() // simple in-memory cache for loaded images.
  private var runningRequests = [UUID: URLSessionDataTask]() // dictionary to keep track of running downloads and cancel them later.
  
  func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {

    // if already exists in cache return it
    if let image = loadedImages[url] {
      completion(.success(image))
      return nil
    }
    // UUID instance that is used to identify the data task
    let uuid = UUID()

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      // remove the running task before we leave the scope of the data task’s completion handler.
      defer {self.runningRequests.removeValue(forKey: uuid) }

      // cache and call the completion handler with the loaded image
      if let data = data, let image = UIImage(data: data) {
        self.loadedImages[url] = image
        completion(.success(image))
        return
      }

      guard let error = error else {
        completion(.failure(HTTP.Error.invalidRequest))
        return
      }

      guard (error as NSError).code == NSURLErrorCancelled else {
        completion(.failure(error))
        return
      }

      // the request was cancelled, no need to call the callback
    }
    task.resume()

    // 6
    runningRequests[uuid] = task
    return uuid
  }

  func cancelLoad(_ uuid: UUID) {
    runningRequests[uuid]?.cancel()
    runningRequests.removeValue(forKey: uuid)
  }
}
