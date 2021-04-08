//
//  EBook.swift
//  EbookListDemo
//
//  Created by Amin Siddiqui on 07/04/21.
//

import Foundation

struct EBookList {
    var nextPageToken: String?
    var eBooks: [Ebook]
}

struct Ebook {
    struct Person {
        let id: String
        let name: String
    }
    
    struct CoverArt {
        let url: String
    }
    
    let id: String
    let title: String
    let authors: [Person]
    let narrators: [Person]
    let cover: CoverArt
}

extension EBookList: Decodable {
    enum CodingKeys: String, CodingKey {
        case nextPageToken
        case eBooks = "items"
    }
}

extension Ebook: Decodable {}
extension Ebook.Person: Decodable {}
extension Ebook.CoverArt: Decodable {}
