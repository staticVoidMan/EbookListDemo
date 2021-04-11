//
//  EbookListProvider_Dummy.swift
//  EbookListDemo
//
//  Created by Amin Siddiqui on 07/04/21.
//

import Foundation

class EbookListProvider_Dummy: EbookListProvider {
    
    var limit: Int
    var throwError: Bool = false
    
    init(limit: Int = 25) {
        self.limit = limit
    }
    
    func getEbooks(containing searchTerm: String, offset: Int, completion: @escaping EbookListProviderCompletion) {
        guard throwError == false else { completion(.failure(NSError())); return }
        
        let startIndex = offset
        let endIndex = min(limit, offset + 10)
        let eBooks: [Ebook] = (startIndex..<endIndex).map { bookIndex in
            var authors = [Ebook.Person]()
            var narrators = [Ebook.Person]()
            
            for idx in 0...min(9, bookIndex) {
                let idx = idx + 1
                let author = Ebook.Person(id: String(idx), name: "Author \(idx)")
                let narrator = Ebook.Person(id: String(idx), name: "Narrator \(idx)")
                
                authors.append(author)
                narrators.append(narrator)
            }
            
            let eBook = Ebook(id: String(bookIndex),
                              title: "\(searchTerm) \(bookIndex + 1)",
                              authors: authors,
                              narrators: narrators,
                              cover: .init(url: ""))
            return eBook
        }
        
        let nextPageToken: String? = {
            if endIndex >= limit {
                return nil
            } else {
                return String(endIndex)
            }
        }()
        let response = EBookList(nextPageToken: nextPageToken,
                                 eBooks: eBooks)
        completion(.success(response))
    }
    
}
