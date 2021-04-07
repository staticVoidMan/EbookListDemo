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
    
    var viewModel: BookListVM = .init(provider: Providers.eBookListProvider)

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
    
    func loadData(searchTerm: String) {
        viewModel.getEbooks(containing: searchTerm) { [weak self] error in
            if let error = error {
                print(error)
            } else {
                //TODO: Reload
                print(self?.viewModel.eBooks)
            }
        }
    }

}

extension BookListVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadData(searchTerm: searchBar.text ?? "")
    }
    
}
