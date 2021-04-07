//
//  EBook.swift
//  EbookListDemo
//
//  Created by Amin Siddiqui on 07/04/21.
//

import Foundation

struct Ebook {
    struct Person {
        let id: Int
        let name: String
    }
    
    struct CoverArt {
        let url: String
    }
    
    let id: Int
    let title: String
    let authors: [Person]
    let narrators: [Person]
    let cover: CoverArt
}
