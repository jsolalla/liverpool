//
//  HomeViewController.swift
//  Liverpool
//
//  Created by Jesus Santa Olalla on 2/16/19.
//  Copyright © 2019 jsolalla. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let homeViewModel = HomeViewModel()
    let disposeBag = DisposeBag.init()
    
    var terms: [RealmSearch] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar("Liverpool")
        setUpSearchBar()
        observe()
        
        tableView.tableFooterView = UIView()
    }
    
    func observe() {
        
        homeViewModel.terms.asObservable().bind { [weak self] (terms) in
            self?.terms = terms
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
        
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
        
        searchViewController.delegate = self
        
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
}

// MARK: - SearchViewControllerDelegate

extension HomeViewController: SearchViewControllerDelegate {
    
    func searchCanceled() {
        homeViewModel.updateTerms()
    }
    
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return terms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTermCell", for: indexPath) as! SearchTermTableViewCell
        cell.configure(terms[indexPath.row])
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let searchBar = navigationItem.searchController?.searchBar {
            navigationItem.searchController?.searchBar.text = terms[indexPath.row].term
            navigationItem.searchController?.searchBar.becomeFirstResponder()
            searchBar.delegate?.searchBarSearchButtonClicked?(searchBar)
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Búsquedas recientes"
    }
    
}
