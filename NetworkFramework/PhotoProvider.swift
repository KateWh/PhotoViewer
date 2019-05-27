//
//  PhotoProvider.swift
//  NetworkFramework
//
//  Created by ket on 5/5/19.
//  Copyright © 2019 ket. All rights reserved.
//

import Foundation

public class PhotoProvider {
    // Create a image cache.
    static var imageCache = NSCache<NSString, UIImage>()
    
    // Loading images.
    static public func downloadImage(url: URL, completionHandler: @escaping (UIImage) -> Void) {
        // Check fo avalibility in the cache.
        // If there are available imgae is taken from it, otherwise image is load.
        if let chacedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            // Return cached image.
            completionHandler(chacedImage)
        } else {
            // Create request and UrlSession.
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
            let dataTask = URLSession.shared.dataTask(with: request) {  data, response, error in
                // Check data.
                guard error == nil,
                    data != nil,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 else {
                        return
                }
                
                // Convert and return the picture.
                guard let image = UIImage(data: data!) else { return }
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                // Return picture in main thread.
                DispatchQueue.main.async {
                    completionHandler(image)
                }
            }
            dataTask.resume()
        }
    }
}
