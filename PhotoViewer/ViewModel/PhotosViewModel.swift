//
//  PicturesViewModel.swift
//  Pictures
//
//  Created by ket on 4/23/19.
//  Copyright © 2019 ket. All rights reserved.
//

import Foundation

class PhotosViewModel {
    
    // Data is prepared for display.
    var photosReceived = [[String]]()
    var photosFound = [String]()
    var lastSearchingResults = [String]()
    
    func getPhotos(onPage page: Int, complitionHandler: @escaping (Error?) -> Void) {
        GettingPhotos.getPhotos(onPage: page) { (photos) in
            // Processing the get data.
            switch photos {
            case .success(let photos):
                // Save data in view model and return no error.
                var count = 3
                var photoArr = [String]()
                for photo in photos {
                    photoArr.append(photo.urls.small)
                    count -= 1
                    if count == 0 {
                        self.photosReceived.append(photoArr)
                        photoArr = []
                        count = 3
                    }
                }
                complitionHandler(nil)
            case .failure(let error):
                // Return error.
                complitionHandler(error)
            }
        }
    }
    
    func searchPhoto(withTitle title: String, complitionHandler: @escaping (Error?) -> Void) {
        GettingPhotos.searchPhoto(withTitle: title) { (photo) in
            // Processing the get data.
            switch photo {
            case .success(let photo):
                // Save data in view model and return no error.
                self.photosFound.append(photo.results[0].urls.small)
                self.lastSearchingResults = [photo.results[0].urls.small]
                complitionHandler(nil)
            case .failure(let error):
                // Return error.
                complitionHandler(error)
            }
        }
    }

}
