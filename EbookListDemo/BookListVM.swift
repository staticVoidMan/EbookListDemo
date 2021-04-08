//
//  BookListVM.swift
//  EbookListDemo
//
//  Created by Amin Siddiqui on 07/04/21.
//

import Foundation

enum BookListVMError: Error {
    case searchTermIsInvalid
    case somethingWentWrong
    
    var message: String {
        switch self {
        case .searchTermIsInvalid:
            return "Please enter a proper search term"
        case .somethingWentWrong:
            return "Something went wrong"
        }
    }
}

class BookListVM {
    
    enum LoadType {
        case none
        case reload
        case append(range: Range<Int>)
    }
    
    private let provider: EbookListProvider
    
    private(set) public var eBooks = [EbookCellVM]()
    
    private var nextPageToken: Int? = 0
    private(set) public var searchTerm = ""
    
    init(provider: EbookListProvider) {
        self.provider = provider
    }
    
    private func isSearchTermValid(_ searchTerm: String) -> Bool {
        let searchTerm = searchTerm.trimmingCharacters(in: .whitespacesAndNewlines)
        let isValid = searchTerm.isEmpty == false
        return isValid
    }
    
    func getEbooks(containing searchTerm: String, completion: @escaping (Result<LoadType, BookListVMError>)->Void) {
        guard isSearchTermValid(searchTerm) else {
            completion(.failure(.searchTermIsInvalid))
            return
        }
        
        if self.searchTerm != searchTerm {
            nextPageToken = 0
        }
        
        guard let nextPageToken = nextPageToken else { completion(.success(.none)); return }
        
        provider.getEbooks(containing: searchTerm, offset: nextPageToken) { [weak self] (result) in
            guard let _weakSelf = self else { return }
            
            switch result {
            case .success(let response):
                let eBooks = response.eBooks.map(EbookCellVM.init)
                _weakSelf.nextPageToken = Int(response.nextPageToken ?? "")
                
                if _weakSelf.searchTerm == searchTerm {
                    let range: Range<Int> = {
                        let startIndex = _weakSelf.eBooks.count
                        let endIndex = startIndex + eBooks.count
                        return startIndex..<endIndex
                    }()
                    _weakSelf.eBooks.append(contentsOf: eBooks)
                    completion(.success(.append(range: range)))
                } else {
                    _weakSelf.searchTerm = searchTerm
                    _weakSelf.eBooks = eBooks
                    completion(.success(.reload))
                }
            case .failure(let error):
                completion(.failure(.somethingWentWrong))
            }
        }
    }
    
}
