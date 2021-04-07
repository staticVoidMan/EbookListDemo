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
    
    let provider: EbookListProvider
    
    var eBooks = [EbookVM]()
    
    init(provider: EbookListProvider) {
        self.provider = provider
    }
    
    private func isSearchTermValid(_ searchTerm: String) -> Bool {
        let searchTerm = searchTerm.trimmingCharacters(in: .whitespacesAndNewlines)
        let isValid = searchTerm.isEmpty == false
        return isValid
    }
    
    func getEbooks(containing searchTerm: String, completion: @escaping (BookListVMError?)->Void) {
        guard isSearchTermValid(searchTerm) else {
            completion(BookListVMError.searchTermIsInvalid)
            return
        }
        
        provider.getEbooks(containing: searchTerm) { (result) in
            switch result {
            case .success(let eBooks):
                let eBooks = eBooks.map(EbookVM.init)
                self.eBooks = eBooks
                
                completion(nil)
            case .failure(let error):
                completion(BookListVMError.somethingWentWrong)
            }
        }
    }
    
}
