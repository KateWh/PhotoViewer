//
//  PhotosTableViewCell.swift
//  Pictures
//
//  Created by ket on 4/26/19.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit
import NetworkFramework

class PhotosTableViewCell: UITableViewCell {

    @IBOutlet var imageViewCollection: [UIImageView]!

    func fillCell(imageURL urlStringArr: [String]) {
        for (index, urlString) in urlStringArr.enumerated() {
            // Create url to download picture.
            guard let url = URL(string: urlString) else { return }
            // Download and set picture.
            NetworkFramework.PhotoProvider.downloadImage(url: url) { image in
                self.imageViewCollection[index].image = image
            }
        }
    }

}
