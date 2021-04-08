//
//  EbookListProvider_API.swift
//  EbookListDemo
//
//  Created by Amin Siddiqui on 09/04/21.
//

import Foundation

struct EbookListProvider_API: EbookListProvider {
    
    func getEbooks(containing searchTerm: String, offset: Int, completion: @escaping EbookListProviderCompletion) {
        let searchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? searchTerm
        let urlString = String(format: APIEndpoints.getBooks, searchTerm, offset)
        
        APIResource<EBookList>(url: urlString).request { (result) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
