//
//  EbookListProvider.swift
//  EbookListDemo
//
//  Created by Amin Siddiqui on 07/04/21.
//

import Foundation

typealias EbookListProviderCompletion = (Result<[Ebook], Error>) -> Void

protocol EbookListProvider {
    func getEbooks(containing searchTerm: String, completion: @escaping EbookListProviderCompletion)
}
