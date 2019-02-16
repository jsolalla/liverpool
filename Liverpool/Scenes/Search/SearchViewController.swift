//
//  SearchViewController.swift
//  Liverpool
//
//  Created by Jesus Santa Olalla on 2/16/19.
//  Copyright © 2019 jsolalla. All rights reserved.
//

import UIKit
import RxSwift

protocol SearchViewControllerDelegate: class {
    func searchCanceled()
}

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let searchViewModel = SearchViewModel()
    let disposeBag = DisposeBag.init()
    
    weak var delegate: SearchViewControllerDelegate?
    
    var products: [SearchRecord] = []
    var searchBar: UISearchBar?
    var activityView: UIView?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observe()
        tableView.tableFooterView = UIView()
    }

    func observe() {
        
        searchViewModel.products.asObservable().bind { [weak self] (products) in
            self?.products = products
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        searchViewModel.message.asObservable().bind { [unowned self] (message) in
            if message.isEmpty == false {
                self.showAlert(message: message)
            }
        }.disposed(by: disposeBag)
        
        searchViewModel.isLoading.asObservable().bind { [unowned self] (isLoading) in
            
            if isLoading {
                self.showAsyncActivityIndicator(in: self.view, completion: { (activityView) in
                    self.activityView = activityView
                })
            } else {
                self.activityView?.removeFromSuperview()
            }
            
        }.disposed(by: disposeBag)
        
    }
    
}

// MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        searchBar = searchController.searchBar
        searchBar?.delegate = self
    }
    
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        products = []
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let textToSearch = searchBar.text {
            searchViewModel.search(term: textToSearch)
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        products = []
        tableView.reloadData()
        delegate?.searchCanceled()
    }
    
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! SearchProductTableViewCell
        cell.configure(products[indexPath.row])
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
