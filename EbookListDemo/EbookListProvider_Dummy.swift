//
//  EbookListProvider_Dummy.swift
//  EbookListDemo
//
//  Created by Amin Siddiqui on 07/04/21.
//

import Foundation

struct EbookListProvider_Dummy: EbookListProvider {
    
    func getEbooks(containing searchTerm: String, completion: @escaping EbookListProviderCompletion) {
        let eBooks: [Ebook] = (0..<5).map { bookIndex in
            var authors = [Ebook.Person]()
            var narrators = [Ebook.Person]()
            
            for idx in 0...bookIndex {
                let author = Ebook.Person(id: idx, name: "Author Name_\(idx)")
                let narrator = Ebook.Person(id: idx, name: "Narrator Name_\(idx)")
                
                authors.append(author)
                narrators.append(narrator)
            }
            
            let eBook = Ebook(id: bookIndex,
                              title: "\(searchTerm)_\(bookIndex)",
                              authors: authors,
                              narrators: narrators,
                              cover: .init(url: ""))
            return eBook
        }
        
        completion(.success(eBooks))
    }
    
}
