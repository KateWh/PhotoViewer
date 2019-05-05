//
//  PhotosTableViewController.swift
//  Pictures
//
//  Created by ket on 4/23/19.
//  Copyright © 2019 ket. All rights reserved.
//

import UIKit

class PhotosTableViewController: UITableViewController, UISearchControllerDelegate {

    // Create viewModel instance.
    let photosViewModel = PhotosViewModel()
    // Create search controller and result controller for it.
    var controladorDeDusca: UISearchController!
    var resultsTableViewController: SearchPhotosTableViewController?
    // A flag to get the pages.
    var paginationCount = 1

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting search.
        resultsTableViewController = storyboard!.instantiateViewController(withIdentifier: "resultsTableViewController") as? SearchPhotosTableViewController
            configurarControladorDeBusca()
        // Get data for display.
        getPhotos()
    }
    
    // Setting search.
    func configurarControladorDeBusca() {
      controladorDeDusca = UISearchController(searchResultsController: resultsTableViewController)
        controladorDeDusca.delegate = self
        controladorDeDusca.searchResultsUpdater = resultsTableViewController
        controladorDeDusca.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        controladorDeDusca.loadViewIfNeeded()
        
        // Configera a barra do Controlador de busca
        controladorDeDusca.searchBar.delegate = resultsTableViewController
        controladorDeDusca.hidesNavigationBarDuringPresentation = false
        controladorDeDusca.searchBar.placeholder = "Search place"
        controladorDeDusca.searchBar.sizeToFit()
        controladorDeDusca.searchBar.barTintColor = navigationController?.navigationBar.barTintColor
        controladorDeDusca.searchBar.tintColor = self.view.tintColor
        
        // Adiciona a bara do Controlador de Dusca a barra do navegador.
        navigationItem.titleView = controladorDeDusca.searchBar
        
    }
    
    func getPhotos() {
        photosViewModel.getPhotos(onPage: paginationCount) { (error) in
            switch error {
            case .none:
                // Reload tableView in main thread..
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .some(_):
                break
                // TODO: Create alert.
            }
        }
    }
    
   
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosViewModel.photosReceived.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PhotosTableViewCell
        cell.fillCell(imageURL: photosViewModel.photosReceived[indexPath.row])
        // Add gesture recognizer to each image view.
        for imageView in cell.imageViewCollection {
            // Create gesture recognizer.
            let pictureTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            // Add gesture recognizer to image view.
            imageView.addGestureRecognizer(pictureTap)
        }
        
        return cell
    }
    
    // Setting a gesture to opening picture.
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
    
    // Setting a gesture to closing the picture.
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        tableView.isScrollEnabled = true
        sender.view?.removeFromSuperview()
        
    }


    // Pagination cells.
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (tableView.contentOffset.y + tableView.frame.size.height) > tableView.contentSize.height, paginationCount < 10 {
            // To get the pages.
            paginationCount += 1
            photosViewModel.getPhotos(onPage: paginationCount){ (error) in
                guard error == nil else {
                    return
                }
                // Reload tableView in main thread.
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}
