//
//  EbookListVC.swift
//  EbookListDemo
//
//  Created by Amin Siddiqui on 07/04/21.
//

import UIKit

class EbookListVC: UIViewController {
    
    static let eBookCellName = "EbookCell"
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.separatorInset = .init(top: 0, left: 8, bottom: 0, right: 0)
        tableView.keyboardDismissMode = .onDrag
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.accessibilityIdentifier = "eBookTableView"
        return tableView
    }()
    
    let noResultsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isHidden = true
        
        label.text = """
            No results found.
            Check the spelling or try different keywords
            """
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.hidesWhenStopped = true
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    var viewModel: EbookListVM!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    func setupView() {
        self.view.addSubview(searchBar)
        self.view.addSubview(tableView)
        self.view.addSubview(noResultsLabel)
        
        setupSearchBar()
        setupTableView()
        setupNoResultsLabel()
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        
        searchBar.frame = .init(x: 0, y: 0, width: 0, height: 64)
        tableView.tableHeaderView = searchBar
    }
    
    func setupTableView() {
        tableView.register(EbookCell.self, forCellReuseIdentifier: Self.eBookCellName)
        
        tableView.backgroundColor = .groupTableViewBackground
        tableView.dataSource = self
        tableView.delegate = self
        
        NSLayoutConstraint.activate([tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                                     tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
        
        addActivityIndicator()
    }
    
    func addActivityIndicator() {
        let loaderView = UIView()
        loaderView.backgroundColor = .clear
        loaderView.frame = .init(x: 0, y: 0, width: 0, height: 96)
        tableView.tableFooterView = loaderView
        
        loaderView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([activityIndicator.centerXAnchor.constraint(equalTo: loaderView.centerXAnchor),
                                     activityIndicator.centerYAnchor.constraint(equalTo: loaderView.centerYAnchor)])
    }
    
    func setupNoResultsLabel() {
        NSLayoutConstraint.activate([noResultsLabel.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
                                     noResultsLabel.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
                                     noResultsLabel.topAnchor.constraint(equalTo: tableView.topAnchor),
                                     noResultsLabel.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)])
    }
    
}

extension EbookListVC {
    
    func loadData(searchTerm: String) {
        activityIndicator.startAnimating()
        
        viewModel.getEbooks(containing: searchTerm) { [weak self] result in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                
                switch result {
                case .success(let loadType):
                    switch loadType {
                    case .none:
                        break
                    case .reload:
                        var showNoResultsLabel: Bool { self?.viewModel.eBooks.isEmpty == false }
                        self?.noResultsLabel.isHidden = showNoResultsLabel
                        self?.tableView.reloadData()
                    case .append(let range):
                        let newIndexPaths = range.map { IndexPath(row: $0, section: 0) }
                        self?.tableView.insertRows(at: newIndexPaths, with: .automatic)
                    }
                case .failure(let error):
                    let alert = UIAlertController(title: "Error", message: error.message, preferredStyle: .alert)
                    alert.addAction(.init(title: "Okay", style: .cancel))
                    self?.present(alert, animated: true)
                }
            }
        }
    }

}

extension EbookListVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadData(searchTerm: searchBar.text ?? "")
        searchBar.resignFirstResponder()
    }
    
}

extension EbookListVC: UITableViewDataSource {
    
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

extension EbookListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var shouldLoadMore: Bool { indexPath.row == viewModel.eBooks.count - 1 }
        
        if shouldLoadMore {
            loadData(searchTerm: viewModel.searchTerm)
        }
    }
    
}
