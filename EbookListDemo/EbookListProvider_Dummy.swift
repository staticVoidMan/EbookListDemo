//
//  EbookListProvider_Dummy.swift
//  EbookListDemo
//
//  Created by Amin Siddiqui on 07/04/21.
//

import Foundation

struct EbookListProvider_Dummy: EbookListProvider {
    
    func getEbooks(containing searchTerm: String, offset: Int, completion: @escaping EbookListProviderCompletion) {
        let startIndex = offset
        let endIndex = offset + 10
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
                              title: "\(searchTerm) \(bookIndex)",
                              authors: authors,
                              narrators: narrators,
                              cover: .init(url: ""))
            return eBook
        }
        
        let nextPageToken: String? = {
            if endIndex >= 50 {
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
