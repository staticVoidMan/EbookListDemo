//
//  EbookListVMTests.swift
//  EbookListDemoTests
//
//  Created by Amin Siddiqui on 09/04/21.
//

import XCTest

class EbookListVMTests: XCTestCase {
    
    var viewModel: EbookListVM!

    override func setUp() {
        super.setUp()
        
        let provider = EbookListProvider_Dummy(limit: 25)
        viewModel = .init(provider: provider)
    }
    
    func testViewModelCanLoadFirstTenBooks() {
        let expectation = XCTestExpectation(description: "Can return first 10 books")
        
        XCTAssertEqual(viewModel.eBooks.count, 0, "Initial Condition, books array must be empty")
        
        let searchTerm = "Lorem ipsum"
        viewModel.getEbooks(containing: searchTerm) { (result) in
            XCTAssertEqual(self.viewModel.eBooks.count, 10, "1st request should end with 10 books")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testViewModelCanLoadAllBooks() {
        let expectation = XCTestExpectation(description: "Can get all books for given search term")
        
        let searchTerm = "Lorem ipsum"
        for i in 0...2 {
            viewModel.getEbooks(containing: searchTerm) { (result) in
                if i == 0 {
                    XCTAssertEqual(self.viewModel.eBooks.count, 10, "1st request should end with 10 books")
                } else if i == 1 {
                    XCTAssertEqual(self.viewModel.eBooks.count, 20, "2nd request should end with 20 books")
                } else if i == 2 {
                    XCTAssertEqual(self.viewModel.eBooks.count, 25, "Last request should end with 25 books")
                    
                    expectation.fulfill()
                }
            }
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testViewModelCanReloadBooksWhenSearchTermChanges() {
        let expectation = XCTestExpectation(description: "New set of books should be available when search term changes")
        
        XCTAssertEqual(viewModel.searchTerm, "", "Initial search term should be empty")
        XCTAssertEqual(viewModel.eBooks.count, 0, "Initial Condition, books array must be empty")
        
        let searchTerm = "Lorem ipsum"
        viewModel.getEbooks(containing: searchTerm) { (result) in
            XCTAssertEqual(self.viewModel.searchTerm, searchTerm, "Search term should be updated")
            XCTAssertEqual(self.viewModel.eBooks.count, 10, "1st request should end with 10 books")
        }
        
        let newSearchTerm = "Dolor set"
        viewModel.getEbooks(containing: newSearchTerm) { (result) in
            XCTAssertEqual(self.viewModel.searchTerm, newSearchTerm, "Search term should be updated")
            XCTAssertEqual(self.viewModel.eBooks.count, 10, "Request should end with fresh 10 books for the updated search term")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }

}
