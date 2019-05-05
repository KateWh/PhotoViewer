//
//  SearchDataForDecoding.swift
//  Pictures
//
//  Created by ket on 4/24/19.
//  Copyright © 2019 ket. All rights reserved.
//

import Foundation

// Data for decoding JSON when searching photo.
struct SearchPhoto: Decodable {
    let results: [OnePhoto]
}

struct OnePhoto: Decodable {
    var urls: SearchImageSize
}

struct SearchImageSize: Decodable {
    let small: String
}

