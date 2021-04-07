//
//  BookListVC.swift
//  EbookListDemo
//
//  Created by Amin Siddiqui on 07/04/21.
//

import UIKit

class BookListVC: UIViewController {
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    func setupView() {
        setupSearchBar()
        //TODO: Implement tableView
    }
    
    func setupSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([searchBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                                     searchBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                                     searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)])
    }
    
    func loadData() {
        //TODO: Implement viewModel to provide list of ebook objects
    }

}

extension BookListVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //TODO: Implement viewModel to accept search term
        print(searchBar.text)
    }
    
}
