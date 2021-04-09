//
//  Providers.swift
//  EbookListDemo
//
//  Created by Amin Siddiqui on 07/04/21.
//

import Foundation

struct Providers {
    
    static var eBookListProvider: EbookListProvider {
        if CommandLine.arguments.contains("enable-ui-testing") {
            return EbookListProvider_Dummy()
        } else {
            return EbookListProvider_API()
        }
        
    }
    
}
