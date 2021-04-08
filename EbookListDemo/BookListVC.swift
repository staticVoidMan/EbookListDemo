//
//  BookListVC.swift
//  EbookListDemo
//
//  Created by Amin Siddiqui on 07/04/21.
//

import UIKit

class BookListVC: UIViewController {
    
    static let eBookCellName = "EbookCell"
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var viewModel: BookListVM = .init(provider: Providers.eBookListProvider)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    func setupView() {
        self.view.addSubview(searchBar)
        self.view.addSubview(tableView)
        
        setupSearchBar()
        setupTableView()
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        
        NSLayoutConstraint.activate([searchBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                                     searchBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                                     searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)])
    }
    
    func setupTableView() {
        tableView.register(EbookCell.self, forCellReuseIdentifier: Self.eBookCellName)
        tableView.dataSource = self
        tableView.delegate = self
        
        NSLayoutConstraint.activate([tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                                     tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor)])
    }
    
    func loadData(searchTerm: String) {
        viewModel.getEbooks(containing: searchTerm) { [weak self] error in
            if let error = error {
                print(error)
            } else {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }

}

extension BookListVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadData(searchTerm: searchBar.text ?? "")
        searchBar.resignFirstResponder()
    }
    
}

extension BookListVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.eBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let eBookVM = viewModel.eBooks[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.eBookCellName,
                                                 for: indexPath) as! EbookCell
        cell.setup(with: eBookVM)
        
        return cell
    }
    
}

extension BookListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.eBooks.count - 1 {
            loadData(searchTerm: searchBar.text ?? "")
        }
    }
    
}
