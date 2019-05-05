//
//  Router.swift
//  Pictures
//
//  Created by ket on 4/24/19.
//  Copyright © 2019 ket. All rights reserved.
//

import Foundation
import NetworkFramework

// Router for link building.
enum UnsplashRouter: Router {
    
    case getPhotos(onPage: Int)
    case searchPhotos(withTitle: String)
    
    // Defining a path.
    var path: String {
        switch self {
        case .getPhotos(let page): return "/photos/?client_id=4c9fbfbbd92c17a2e95081cec370b4511659666240eb4db9416c40c641ee843b&page=\(page)&per_page=30"
        case .searchPhotos(let title): return "/search/photos/?client_id=4c9fbfbbd92c17a2e95081cec370b4511659666240eb4db9416c40c641ee843b&query=\(title)&per_page=1"
        }
    }
    
    // Defining a base url.
    var baseURL: String {
        return "https://api.unsplash.com"
    }
    
    // Creating and return the link.
    func getURL() -> URL {
        let url = URL(string: self.baseURL + self.path)
        return url!
    }
    
}

