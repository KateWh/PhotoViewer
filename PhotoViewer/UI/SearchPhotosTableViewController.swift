//
//  SearchPhotosTableViewController.swift
//  Pictures
//
//  Created by ket on 4/27/19.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

class SearchPhotosTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    // Create viewModel instance.
    let photosViewModel = PhotosViewModel()

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosViewModel.photosFound.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchPhotosTableViewCell
        // Create reverse array of pictures.
        let reversePhotoSerched = (photosViewModel.photosFound.count - 1) - indexPath.row
        cell.fillCell(imageURL: photosViewModel.photosFound[reversePhotoSerched])
        // Create gesture recognizer.
        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        // Add gesture recognizer.
        cell.myImageView.addGestureRecognizer(pictureTap)
        return cell
    }

    //Setting a gesture to opening picture.
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        
        navigationController?.isNavigationBarHidden = true
        tableView.isScrollEnabled = false
        newImageView.frame = tableView.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
    }
    
    //Setting a gesture to closing the picture.
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        tableView.isScrollEnabled = true
        sender.view?.removeFromSuperview()
    }

    
    // Updates search after the introduction of characters.
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, searchController.searchBar.text?.count ?? 0 > 3 else { return }
        photosViewModel.searchPhoto(withTitle: searchText ) { (error) in
            switch error {
            case .none:
                // Reload tableView.
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .some(_):
                break
                // TODO: Create alert.
            }
            
        }
    }

    // Updates search after the tap of enter.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
    }
  
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    // Delete seach array when close seach.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete, indexPath.row == 0 else { return }
       photosViewModel.photosFound.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
