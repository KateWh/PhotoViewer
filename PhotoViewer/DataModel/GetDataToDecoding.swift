//
//  DataToDecoding.swift
//  Pictures
//
//  Created by ket on 4/23/19.
//  Copyright © 2019 ket. All rights reserved.
//

import Foundation

// Data for decoding JSON when receiving photos.
struct GetPhoto: Decodable {
    let urls: GetImageSizes
}

struct GetImageSizes: Decodable {
    let small: String
}
