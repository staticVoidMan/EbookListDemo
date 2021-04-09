//
//  EbookCellVM.swift
//  EbookListDemo
//
//  Created by Amin Siddiqui on 07/04/21.
//

import Foundation

struct EbookCellVM {
    private let eBook: Ebook
    
    var eBookTitleName: String { eBook.title }
    
    var authorNamesText: String { "By: " + eBook.authors.map { $0.name }.joined(separator: ", ") }
    
    var narratorNamesText: String {
        if eBook.narrators.isEmpty {
            return " "
        } else {
            return "With: " + eBook.narrators.map { $0.name }.joined(separator: ", ")
        }
    }
    
    var imageURL: URL? { URL(string: eBook.cover.url) }
    
    init(eBook: Ebook) {
        self.eBook = eBook
    }
}
