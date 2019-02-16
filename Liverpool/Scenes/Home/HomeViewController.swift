//
//  HomeViewController.swift
//  Liverpool
//
//  Created by Jesus Santa Olalla on 2/16/19.
//  Copyright © 2019 jsolalla. All rights reserved.
//

import UIKit
import RxCocoa

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar("Liverpool")
        setUpSearchBar()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setUpSearchBar() {
        
        guard let searchViewController = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else {
            return
        }
        
        let searchController = UISearchController(searchResultsController: searchViewController)
        searchController.searchResultsUpdater = searchViewController
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Buscar productos"
        searchController.searchBar.tintColor = .white
        searchController.searchBar.setBackgroundColor(color: .white)
        
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
}
