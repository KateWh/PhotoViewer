//
//  Router.swift
//  NetworkFramework
//
//  Created by ket on 5/5/19.
//  Copyright © 2019 ket. All rights reserved.
//

import Foundation

public protocol Router {
    // Set path.
    var path: String { get }
    // Set base url.
    var baseURL: String { get }
    // Create and return url.
     func getURL() -> URL
}
