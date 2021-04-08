//
//  Providers.swift
//  EbookListDemo
//
//  Created by Amin Siddiqui on 07/04/21.
//

import Foundation

struct Providers {
    
    static var eBookListProvider: EbookListProvider {
        return EbookListProvider_API()
    }
    
}
