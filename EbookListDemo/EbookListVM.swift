//
//  EbookListVM.swift
//  EbookListDemo
//
//  Created by Amin Siddiqui on 07/04/21.
//

import Foundation

enum EbookListVMError: Error {
    case searchTermIsInvalid
    case somethingWentWrong(error: Error?)
    
    var message: String {
        switch self {
        case .searchTermIsInvalid:
            return "Please enter a proper search term"
        case .somethingWentWrong(let error):
            return error?.localizedDescription ?? "Something went wrong"
        }
    }
}

class EbookListVM {
    
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
    
    func getEbooks(containing searchTerm: String, completion: @escaping (Result<LoadType, EbookListVMError>)->Void) {
        guard isSearchTermValid(searchTerm) else {
            completion(.failure(.searchTermIsInvalid))
            return
        }
        
        var hasSearchTermChanged: Bool { self.searchTerm != searchTerm }
        if hasSearchTermChanged {
            //search term changed so reset page token for fresh request
            nextPageToken = 0
        }
        
        guard let nextPageToken = nextPageToken else { completion(.success(.none)); return }
        
        provider.getEbooks(containing: searchTerm, offset: nextPageToken) { [weak self] (result) in
            guard let _weakSelf = self else { return }
            
            switch result {
            case .success(let response):
                var hasSearchTermChanged: Bool { _weakSelf.searchTerm != searchTerm }
                
                let eBooks = response.eBooks.map(EbookCellVM.init)
                _weakSelf.nextPageToken = Int(response.nextPageToken ?? "")
                
                if hasSearchTermChanged {
                    //search term has changed so reset array
                    _weakSelf.searchTerm = searchTerm
                    _weakSelf.eBooks = eBooks
                    
                    completion(.success(.reload))
                } else {
                    //search term has not changed so append result
                    let appendRange: Range<Int> = {
                        let startIndex = _weakSelf.eBooks.count
                        let endIndex = startIndex + eBooks.count
                        return startIndex..<endIndex
                    }()
                    _weakSelf.eBooks.append(contentsOf: eBooks)
                    
                    completion(.success(.append(range: appendRange)))
                }
            case .failure(let error):
                completion(.failure(.somethingWentWrong(error: error)))
            }
        }
    }
    
}
