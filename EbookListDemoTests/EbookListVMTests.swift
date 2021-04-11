//
//  EbookListVMTests.swift
//  EbookListDemoTests
//
//  Created by Amin Siddiqui on 09/04/21.
//

import XCTest

class EbookListVMTests: XCTestCase {
    
    var provider: EbookListProvider_Dummy!
    var viewModel: EbookListVM!

    override func setUp() {
        super.setUp()
        
        provider = EbookListProvider_Dummy(limit: 25)
        viewModel = .init(provider: provider)
    }
    
    func testViewModelCanLoadFirstTenBooks() {
        let expectation = XCTestExpectation(description: "Can return first 10 books")
        
        XCTAssertEqual(viewModel.eBooks.count, 0, "Initial Condition, books array must be empty")
        
        let searchTerm = "Lorem ipsum"
        viewModel.getEbooks(containing: searchTerm) { (result) in
            XCTAssertEqual(self.viewModel.eBooks.count, 10, "1st request should end with 10 books")
            XCTAssertEqual(self.viewModel.eBooks[9].eBookTitleName, "Lorem ipsum 10", "Expected book name")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testViewModelCanLoadAllBooks() {
        let expectation = XCTestExpectation(description: "Can get all books for given search term")
        
        let searchTerm = "Lorem ipsum"
        for i in 0...3 {
            viewModel.getEbooks(containing: searchTerm) { (result) in
                if i == 0 {
                    XCTAssertEqual(self.viewModel.eBooks.count, 10, "1st request should end with 10 books")
                    XCTAssertEqual(self.viewModel.eBooks[9].eBookTitleName, "Lorem ipsum 10", "Expected name mismatch")
                } else if i == 1 {
                    XCTAssertEqual(self.viewModel.eBooks.count, 20, "2nd request should end with 20 books")
                    XCTAssertEqual(self.viewModel.eBooks[19].eBookTitleName, "Lorem ipsum 20", "Expected name mismatch")
                } else if i == 2 {
                    XCTAssertEqual(self.viewModel.eBooks.count, 25, "3rd request should end with all 25 books")
                    XCTAssertEqual(self.viewModel.eBooks[24].eBookTitleName, "Lorem ipsum 25", "Expected name mismatch")
                } else if i == 3 {
                    XCTAssertEqual(self.viewModel.eBooks.count, 25, "Last request should not increase book count")
                    
                    expectation.fulfill()
                }
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testViewModelCanReloadBooksWhenSearchTermChanges() {
        let expectation = XCTestExpectation(description: "New set of books should be available when search term changes")
        
        XCTAssertEqual(viewModel.searchTerm, "", "Initial search term should be empty")
        XCTAssertEqual(viewModel.eBooks.count, 0, "Initial Condition, books array must be empty")
        
        let searchTerm = "Lorem ipsum"
        viewModel.getEbooks(containing: searchTerm) { (result) in
            XCTAssertEqual(self.viewModel.searchTerm, searchTerm, "Search term should be updated")
            XCTAssertEqual(self.viewModel.eBooks.count, 10, "1st request should end with 10 books")
            XCTAssertEqual(self.viewModel.eBooks[9].eBookTitleName, "Lorem ipsum 10", "Expected name mismatch")
        }
        
        let newSearchTerm = "Dolor set"
        viewModel.getEbooks(containing: newSearchTerm) { (result) in
            XCTAssertEqual(self.viewModel.searchTerm, newSearchTerm, "Search term should be updated")
            XCTAssertEqual(self.viewModel.eBooks.count, 10, "Request should end with fresh 10 books for the updated search term")
            XCTAssertEqual(self.viewModel.eBooks[9].eBookTitleName, "Dolor set 10", "Expected name mismatch")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testViewModelCanHandleZeroResults() {
        let expectation = XCTestExpectation(description: "Can search but handle response with 0 books")
        
        provider.limit = 0
        
        XCTAssertEqual(viewModel.eBooks.count, 0, "Initial Condition, books array must be empty")
        
        let searchTerm = "TILT"
        viewModel.getEbooks(containing: searchTerm) { (result) in
            XCTAssertEqual(self.viewModel.eBooks.count, 0, "Expected search to return an empty books array")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testViewModelCanPassOnError() {
        let expectation = XCTestExpectation(description: "Can handle error when getting books")
        
        provider.throwError = true
        
        let searchTerm = "Lorem ipsum"
        viewModel.getEbooks(containing: searchTerm) { (result) in
            switch result {
            case .success:
                XCTAssert(false, "Expected to fail")
            case .failure:
                XCTAssert(true, "Expected to fail")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }

}
