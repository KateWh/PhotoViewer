//
//  GetPhotos.swift
//  Pictures
//
//  Created by ket on 4/23/19.
//  Copyright © 2019 ket. All rights reserved.
//

import Foundation
import NetworkFramework

struct GettingPhotos {
    
    static func getPhotos(onPage page: Int, completionHandler: @escaping (Result<[GetPhoto]>) -> Void){
        // TODO: Create Error for alert handler.
        
        // Call URLSession.
        URLSession.shared.dataTask(with: UnsplashRouter.getPhotos(onPage: page).getURL()) { (data, response, error) in
            // Check the presence of data.
            guard let data = data else {
                // Return Error.
                return completionHandler(.failure(error!))
            }
            
            // Unwrapper JSON.
            do {
                let photos = try JSONDecoder().decode([GetPhoto].self, from: data)
                // Return photos array.
                completionHandler(.success(photos))
            } catch {
                // Return Error.
                completionHandler(.failure(error))
            }
        }.resume()
    }
    
    
    static func searchPhoto(withTitle title: String, completionHandler: @escaping (Result<SearchPhoto>) -> Void) {
        // Call URLSession.
        URLSession.shared.dataTask(with: UnsplashRouter.searchPhotos(withTitle: title).getURL()) { (data, response, error) in
            // Check the presence of data.
            guard let data = data else {
                // Return Error.
                return completionHandler(.failure(error!))
            }
            
            // Unwrapper JSON.
            do {
                let photo = try JSONDecoder().decode(SearchPhoto.self, from: data)
                //Return photo.
                if  photo.results.count > 0 {
                    completionHandler(.success(photo))
                } else {
                    completionHandler(.failure(NSError()))
                }
            } catch {
                // Return Error.
                completionHandler(.failure(error))
            }
        }.resume()
    }
   
    
}
