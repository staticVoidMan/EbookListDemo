//
//  EbookListProvider.swift
//  EbookListDemo
//
//  Created by Amin Siddiqui on 07/04/21.
//

import Foundation

typealias EbookListProviderCompletion = (Result<EBookList, Error>) -> Void

protocol EbookListProvider {
    func getEbooks(containing searchTerm: String, offset: Int, completion: @escaping EbookListProviderCompletion)
}
