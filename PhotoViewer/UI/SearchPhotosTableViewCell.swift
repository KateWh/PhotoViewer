//
//  SearchPhotosTableViewCell.swift
//  Pictures
//
//  Created by ket on 4/27/19.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit
import NetworkFramework

class SearchPhotosTableViewCell: UITableViewCell {

    @IBOutlet weak var myImageView: UIImageView!
    
    // Create photoProvider instance.
    func fillCell(imageURL urlString: String){
        // Create url to download picture.
        guard let url = URL(string: urlString) else { return }
        // Download and set picture.
        NetworkFramework.PhotoProvider.downloadImage(url: url) { (image) in
            self.myImageView.image = image
        }
    }

}
